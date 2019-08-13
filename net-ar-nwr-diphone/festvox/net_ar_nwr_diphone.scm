;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-*-mode:scheme-*-
;;;                                                                       ;;
;;;                            [SOMEBODY]                                 ;;
;;;                         Copyright (c) 2000                            ;;
;;;                        All Rights Reserved.                           ;;
;;;                                                                       ;;
;;;  Distribution policy                                                  ;;
;;;     [CHOOSE ONE OF]                                                   ;;
;;;     Free for any use                                                  ;;
;;;     Free for non commercial use                                       ;;
;;;     something else                                                    ;;
;;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  An example diphone voice
;;;
;;;  Authors: [The people who did the work]
;;;
;; set debug option
(debug_output t)
;;; Try to find out where we are
(if (assoc 'net_ar_nwr_diphone voice-locations)
    (defvar net_ar_nwr_dir 
      (cdr (assoc 'net_ar_nwr_diphone voice-locations)))
    ;;; Not installed in Festival yet so assume running in place
    (defvar net_ar_nwr_dir (pwd)))

(if (not (probe_file (path-append net_ar_nwr_dir "festvox/")))
    (begin
     (format stderr "net_ar_nwr: Can't find voice scm files they are not in\n")
     (format stderr "   %s\n" (path-append net_ar_nwr_dir "festvox/"))
     (format stderr "   Either the voice isn't linked into Festival\n")
     (format stderr "   or you are starting festival in the wrong directory\n")
     (error)))

;;;  Add the directory contains general voice stuff to load-path
(set! load-path (cons (path-append net_ar_nwr_dir "festvox/") load-path))

;;; Voice specific parameter are defined in each of the following
;;; files
(require 'net_ar_nwr_phoneset)
(require 'net_ar_nwr_tokenizer)
(require 'net_ar_nwr_tagger)
(require 'net_ar_nwr_lexicon)
(require 'net_ar_nwr_phrasing)
(require 'net_ar_nwr_intonation)
(require 'net_ar_nwr_duration)
(require 'net_ar_nwr_f0model)
(require 'net_ar_nwr_other)
;; ... and others as required

;;;  Ensure we have a festival with the right diphone support compiled in
(require_module 'UniSyn)

(set! net_ar_nwr_lpc_sep 
      (list
       '(name "net_ar_nwr_lpc_sep")
       (list 'index_file (path-append net_ar_nwr_dir "dic/nwrdiph.est"))
       '(grouped "false")
       (list 'coef_dir (path-append net_ar_nwr_dir "lpc"))
       (list 'sig_dir  (path-append net_ar_nwr_dir "lpc"))
       '(coef_ext ".lpc")
       '(sig_ext ".res")
       (list 'default_diphone 
	     (string-append
	      (car (cadr (car (PhoneSet.description '(silences)))))
	      "-"
	      (car (cadr (car (PhoneSet.description '(silences)))))))))

(set! net_ar_nwr_lpc_group 
      (list
       '(name "nwr_lpc_group")
       (list 'index_file 
	     (path-append net_ar_nwr_dir "group/nwrlpc.group"))
       '(grouped "true")
       (list 'default_diphone 
	     (string-append
	      (car (cadr (car (PhoneSet.description '(silences)))))
	      "-"
	      (car (cadr (car (PhoneSet.description '(silences)))))))))

;; Go ahead and set up the diphone db
(set! net_ar_nwr_db_name (us_diphone_init net_ar_nwr_lpc_sep))
;; Once you've built the group file you can comment out the above and
;; uncomment the following.
;(set! net_ar_nwr_db_name (us_diphone_init net_ar_nwr_lpc_group))

(define (net_ar_nwr_diphone_fix utt)
"(net_ar_nwr_diphone_fix UTT)
Map phones to phonological variants if the diphone database supports
them."
  (mapcar
   (lambda (s)
     (let ((name (item.name s)))
       (net_ar_nwr_diphone_fix_phone_name utt s)
       ))
   (utt.relation.items utt 'Segment))
  utt)

(define (net_ar_nwr_diphone_fix_phone_name utt seg)
"(net_ar_nwr_fix_phone_name UTT SEG)
Add the feature diphone_phone_name to given segment with the appropriate
name for constructing a diphone.  Basically adds _ if either side is part
of the same consonant cluster, adds $ either side if in different
syllable for preceding/succeeding vowel syllable."
  (let ((name (item.name seg)))
    (cond
     ((string-equal name "pau") t)
     ((string-equal "-" (item.feat seg 'ph_vc))
      (if (and (member_string name '(r w y l))
	       (member_string (item.feat seg "p.name") '(p t k b d g))
	       (item.relation.prev seg "SylStructure"))
	  (item.set_feat seg "us_diphone_right" (format nil "_%s" name)))
      (if (and (member_string name '(w y l m n p t k))
	       (string-equal (item.feat seg "p.name") 's)
	       (item.relation.prev seg "SylStructure"))
	  (item.set_feat seg "us_diphone_right" (format nil "_%s" name)))
      (if (and (string-equal name 's)
	       (member_string (item.feat seg "n.name") '(w y l m n p t k))
	       (item.relation.next seg "SylStructure"))
	  (item.set_feat seg "us_diphone_left" (format nil "%s_" name)))
      (if (and (string-equal name 'hh)
	       (string-equal (item.feat seg "n.name") 'y))
	  (item.set_feat seg "us_diphone_left" (format nil "%s_" name)))
      (if (and (string-equal name 'y)
	       (string-equal (item.feat seg "p.name") 'hh))
	  (item.set_feat seg "us_diphone_right" (format nil "_%s" name)))
      (if (and (member_string name '(p t k b d g))
	       (member_string (item.feat seg "n.name") '(r w y l))
	       (item.relation.next seg "SylStructure"))
	  (item.set_feat seg "us_diphone_left" (format nil "%s_" name)))
      )
     ((string-equal "ah" (item.name seg))
      (item.set_feat seg "us_diphone" "aa"))

   )))

(define (net_ar_nwr_voice_reset)
  "(net_ar_nwr_voice_reset)
Reset global variables back to previous voice."
  (net_ar_nwr::reset_phoneset)
  (net_ar_nwr::reset_tokenizer)
  (net_ar_nwr::reset_tagger)
  (net_ar_nwr::reset_lexicon)
  (net_ar_nwr::reset_phrasing)
  (net_ar_nwr::reset_intonation)
  (net_ar_nwr::reset_duration)
  (net_ar_nwr::reset_f0model)
  (net_ar_nwr::reset_other)
)

;;;  Full voice definition 
(define (voice_net_ar_nwr_diphone)
"(voice_net_ar_nwr_diphone)
Set speaker to nwr in us from net."
  ;; Select appropriate phone set
  (net_ar_nwr::select_phoneset)

  ;; Select appropriate tokenization
  (net_ar_nwr::select_tokenizer)

  ;; For part of speech tagging
  (net_ar_nwr::select_tagger)

  (net_ar_nwr::select_lexicon)

  (net_ar_nwr::select_phrasing)

  (net_ar_nwr::select_intonation)

  (net_ar_nwr::select_duration)

  (net_ar_nwr::select_f0model)

  ;; Waveform synthesizer: UniSyn diphones
  (set! UniSyn_module_hooks (list net_ar_nwr_diphone_fix))
  (set! us_abs_offset 0.0)
  (set! window_factor 1.0)
  (set! us_rel_offset 0.0)
  (set! us_gain 0.9)

  (Parameter.set 'Synth_Method 'UniSyn)
  (Parameter.set 'us_sigpr 'lpc)
  (us_db_select net_ar_nwr_db_name)

  ;; This is where you can modify power (and sampling rate) if desired
  (set! after_synth_hooks nil)
;  (set! after_synth_hooks
;      (list
;        (lambda (utt)
;          (utt.wave.rescale utt 2.1))))

  ;; set callback to restore some original values changed by this voice
  (set! current_voice_reset net_ar_nwr_voice_reset)

  (set! current-voice 'net_ar_nwr_diphone)
)

(proclaim_voice
 'net_ar_nwr_diphone
 '((language english)
   (gender COMMENT)
   (dialect american)
   (description
    "COMMENT"
    )
   (builtwith festvox-1.3)))

(provide 'net_ar_nwr_diphone)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                     Carnegie Mellon University                      ;;;
;;;                  and Alan W Black and Kevin Lenzo                   ;;;
;;;                      Copyright (c) 1998-2000                        ;;;
;;;                        All Rights Reserved.                         ;;;
;;;                                                                     ;;;
;;; Permission is hereby granted, free of charge, to use and distribute ;;;
;;; this software and its documentation without restriction, including  ;;;
;;; without limitation the rights to use, copy, modify, merge, publish, ;;;
;;; distribute, sublicense, and/or sell copies of this work, and to     ;;;
;;; permit persons to whom this work is furnished to do so, subject to  ;;;
;;; the following conditions:                                           ;;;
;;;  1. The code must retain the above copyright notice, this list of   ;;;
;;;     conditions and the following disclaimer.                        ;;;
;;;  2. Any modifications must be clearly marked as such.               ;;;
;;;  3. Original authors' names are not deleted.                        ;;;
;;;  4. The authors' names are not used to endorse or promote products  ;;;
;;;     derived from this software without specific prior written       ;;;
;;;     permission.                                                     ;;;
;;;                                                                     ;;;
;;; CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK        ;;;
;;; DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING     ;;;
;;; ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT  ;;;
;;; SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE     ;;;
;;; FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   ;;;
;;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN  ;;;
;;; AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,         ;;;
;;; ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF      ;;;
;;; THIS SOFTWARE.                                                      ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tokenizer for ar
;;;
;;;  To share this among voices you need to promote this file to
;;;  to say festival/lib/net_ar/ so others can use it.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Load any other required files

;; Punctuation for the particular language
(set! net_ar_nwr::token.punctuation "\"'`.,:;!?(){}[]")
(set! net_ar_nwr::token.prepunctuation "\"'`({[")
(set! net_ar_nwr::token.whitespace " \t\n\r")
(set! net_ar_nwr::token.singlecharsymbols "")

;;; Voice/ar token_to_word rules 
(define (net_ar_nwr::token_to_words token name)
  "(net_ar_nwr::token_to_words token name)
Specific token to word rules for the voice net_ar_nwr.  Returns a list
of words that expand given token with name."
  (cond
   ((string-matches name "[1-9][0-9]+")
    (net_ar::number token name))
   (t ;; when no specific rules apply do the general ones
    (list name))))

(define (net_ar::number token name)
  "(net_ar::number token name)
Return list of words that pronounce this number in ar."

  (error "net_ar::number to be written\n")

)

(define (net_ar_nwr::select_tokenizer)
  "(net_ar_nwr::select_tokenizer)
Set up tokenizer for ar."
  (Parameter.set 'Language 'net_ar)
  (set! token.punctuation net_ar_nwr::token.punctuation)
  (set! token.prepunctuation net_ar_nwr::token.prepunctuation)
  (set! token.whitespace net_ar_nwr::token.whitespace)
  (set! token.singlecharsymbols net_ar_nwr::token.singlecharsymbols)

  (set! token_to_words net_ar_nwr::token_to_words)
)

(define (net_ar_nwr::reset_tokenizer)
  "(net_ar_nwr::reset_tokenizer)
Reset any globals modified for this voice.  Called by 
(net_ar_nwr::voice_reset)."
  ;; None

  t
)

(provide 'net_ar_nwr_tokenizer)

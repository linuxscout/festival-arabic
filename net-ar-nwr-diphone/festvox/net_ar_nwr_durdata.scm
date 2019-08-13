;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                       ;;
;;;                Centre for Speech Technology Research                  ;;
;;;                     University of Edinburgh, UK                       ;;
;;;                       Copyright (c) 1996,1997                         ;;
;;;                        All Rights Reserved.                           ;;
;;;                                                                       ;;
;;;  Permission to use, copy, modify, distribute this software and its    ;;
;;;  documentation for research, educational and individual use only, is  ;;
;;;  hereby granted without fee, subject to the following conditions:     ;;
;;;   1. The code must retain the above copyright notice, this list of    ;;
;;;      conditions and the following disclaimer.                         ;;
;;;   2. Any modifications must be clearly marked as such.                ;;
;;;   3. Original authors' names are not deleted.                         ;;
;;;  This software may not be used for commercial purposes without        ;;
;;;  specific prior written permission from the authors.                  ;;
;;;                                                                       ;;
;;;  THE UNIVERSITY OF EDINBURGH AND THE CONTRIBUTORS TO THIS WORK        ;;
;;;  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      ;;
;;;  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   ;;
;;;  SHALL THE UNIVERSITY OF EDINBURGH NOR THE CONTRIBUTORS BE LIABLE     ;;
;;;  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    ;;
;;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ;;
;;;  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ;;
;;;  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ;;
;;;  THIS SOFTWARE.                                                       ;;
;;;                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   A hand specified tree to predict zcore durations
;;;
;;;

(set! net_ar_nwr::zdur_tree 
 '
   ((R:SylStructure.parent.R:Syllable.p.syl_break > 1 ) ;; clause initial
    ((1.5))
    ((R:SylStructure.parent.syl_break > 1)   ;; clause final
     ((1.5))
     ((1.0)))))

(set! net_ar_nwr::phone_durs
 ;; should be hand specified
  '( ( pau 0.2 0.1)
   ( a 0.01    0.023 )
	( u 0.01    0.023 )
	( i 0.01    0.023 )
	( a:    0.01    0.023 )
	( u:    0.01    0.023 )
	( i:    0.01    0.023 )
	( ?   0.01    0.023 )
	( b 0.01    0.023 )
	( t 0.01    0.023 )
	( th    0.01    0.023 )
	( j 0.01    0.023 )
	( ha    0.01    0.023 )
	( kh    0.01    0.023 )
	( d 0.01    0.023 )
	( dh    0.01    0.023 )
	( r 0.01    0.023 )
	( z 0.01    0.023 )
	( s 0.01    0.023 )
	( sh    0.01    0.023 )
	( sa    0.01    0.023 )
	( da    0.01    0.023 )
	( ta    0.01    0.023 )
	( zh    0.01    0.023 )
	( E 0.01    0.023 )
	( gh    0.01    0.023 )
	( f 0.01    0.023 )
	( q 0.01    0.023 )
	( k 0.01    0.023 )
	( l 0.01    0.023 )
	( m 0.01    0.023 )
	( n 0.01    0.023 )
	( h 0.01    0.023 )
	( w 0.01    0.023 )
	( y 0.01    0.023 )
	( p 0.01    0.023 )
	( v 0.01    0.023 )
	( g 0.01    0.023)
   )
 ;; But this will fake it until you build a duration model 
 ;(mapcar
 ; (lambda (p)
  ;  (list (car p) 0.0 0.100))
  ;(cadr (assoc_string 'phones (PhoneSet.description ))))
)

(provide 'net_ar_nwr_durdata)

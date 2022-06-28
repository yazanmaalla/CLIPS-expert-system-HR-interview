(deftemplate  data
 (slot name )  (slot age )  (slot study )  )

 (deffacts  fac
  
 (old accountant driver guard ele-eng)

  )



    

(deffunction askq (?question $?value)
(printout t ?question )
(bind ?answer(read))
(if(lexemep ?answer)
then
(bind ?answer (lowcase ?answer)))
(while (not(member $?answer ?value))
do (printout t ?question )(bind ?answer(read)))
(if(lexemep ?answer)
then
(bind ?answer (lowcase ?answer)))
?answer)


(deffunction askqq (?question )
(printout t ?question )
(bind ?answer(read))
?answer)


(deffunction askn (?question )
(printout t ?question )
(bind ?answer(read-number))
?answer)

(defrule r0 
 (declare (salience 100))
=> (assert (es start )) ) 



(defrule r1 
(declare (salience 99))
(or (es start) (es continue ? ) )
 => (printout t "welcome to our Bank job interview . " crlf )
    (bind ?n (askqq"What is your name ? " ) )
    (bind ?r (askn"How old are you  ? " ) )
     (if (or (< ?r 18)  (= ?r 18) ) 
      then (printout t "  Sorry  "  ?n", you are too young to be employed. " crlf)
       (assert ( data (name ?n ) (age ?r )))
    else 
    (bind ?b (askq" what's your domain ?,the desired domains are (prog-eng / ele-eng / economy / law / english / none) " prog-eng ele-eng economy law english none ) )
    (assert ( data (name ?n ) (age ?r ) (study ?b ) ) )  ) )



(defrule r2
(declare (salience 98))
(data (name ?n) (age ?age) (study none ) )
(test(> ?age 18)) 
=>(bind ?gender (askq "what's your gender (male / female) ?" male female ))
( if ( eq ?gender male) 
  then 
  (bind ?an (askq " Do you have a driving licence ( yes / no )?" yes no ))
  (bind ?k (askq " Can you travel to our new center in Aleppo (yes / no ) ?" yes no))
  (if (eq ?an  yes) 
   then
 (assert (job ?n driver ?k) )
else 
 (assert (job ?n guard ?k) )

  )
else 
 (bind ?k (askq "Can you travel to our new center in Aleppo (yes / no ) ?" yes no))
(assert (job ?n cleaner ?k) ) ) ) 



(defrule r3
 (declare (salience 97))
(data (name ?n) (age ?)  (study ?s )  )
  => ( if (not (or (eq ?s nil ) (eq ?s none ))) then
  (bind ?e (askn "how many years of expert do you have?" ))
   (if (< ?e 2) 
   then
  (printout t " Sorry," ?n " you must have been training at least for 2 years .  " crlf)
else 
  (bind ?lan (askq "what's about your language( bad[b]  / good[g]  )?" g b ))
 (if (eq ?lan  b ) 
   then 
   (printout t " Sorry," ?n " you have to improve your language skills ." crlf)
else 
 (bind ?comp (askq "how much expert of computer do you have(  bad[b]  / good[g]  )?" g b ))
(if ( eq ?comp b) 
   then 
(printout t " Sorry,"?n " you have to improve your computer skills ." crlf)
  else
(bind ?k (askq "Can you travel to our new center in Aleppo (yes / no ) ?" yes no))
  ( if ( eq ?s  prog-eng ) 
    then ( assert ( job   ?n  programming-engineer  ?k ) ) )
( if ( eq ?s  ele-eng ) 
    then ( assert ( job   ?n  electrical-engineer  ?k) ) )
( if ( eq ?s  law  ) 
    then ( assert ( job   ?n  lawyer  ?k ) ) )
( if ( eq ?s  english ) 
    then ( assert ( job   ?n translator  ?k ) ) )
( if ( eq ?s  economy ) 
    then ( assert ( job   ?n  accountant  ?k ) ) )
) ) )  ))



  (defrule r4
   (declare (salience 96))
  (job ?n ?s ?k ) (old $?y)
=>  (if (eq ?k yes ) then  
    (  printout t ?n ",  you are welcome to work as a " ?s "  at our branch in Aleppo "crlf )
  else 
    
    (if ( member  $?s  $?y  ) then 
       (  printout t ?n ",  you are welcome to work as a " ?s "  at our branch in Lattakia "crlf )
     else 
     (printout t "Sorry, " ?n " . there is no functional vaccant right now ! "crlf ) ) 
         ) )

 

(defrule r5
(declare (salience 90))
  ( data (name ?n ) (age ? ) ) 
=>(bind ?tu (askq "Is there a new interviewed person ? (yes/no )" yes no ))
  (if (eq ?tu yes) 
   then 
(assert ( es continue ?n ))
   else 
(printout t " Thank you ! "crlf )
 (bind ?d (askq" Do you want to show results ? " yes no ) )
  (if (eq  ?d yes )  then 
    (assert ( show res) ) )  
))
(defrule r6 
 (show res ) ( job ?n ?s ?k) 
=> (if (eq ?k yes ) then 
   (printout t ?n " is accepted as a " ?s " in Aleppo . "crlf )
   else 
   (printout t ?n " is accepted as a " ?s " in Lattakia  . "crlf ) 
    ) ) 



(defrule r7 
 (show res )  ( data (name ?n) ) (not ( job ?n $?)) 
  => (printout t ?n " is refused  . "crlf )
    )



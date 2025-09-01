(defun c:LPL (/ layer ss n ent obj total)
  (setq layer (getstring "\nEnter layer name: "))
  (setq ss (ssget "X" (list (cons 8 layer) (cons 0 "LWPOLYLINE")))) ; selects LWPOLYLINEs in the specified layer
  (setq total 0.0)

  (if ss
    (progn
      (setq n 0)
      (while (< n (sslength ss))
        (setq ent (ssname ss n))
        (setq obj (vlax-ename->vla-object ent))
        (setq total (+ total (vlax-curve-getDistAtParam obj (vlax-curve-getEndParam obj))))
        (setq n (1+ n))
      )
      (princ (strcat "\nTotal Length of polylines in layer \"" layer "\" = "
                     (rtos total 2 3)
                     " cm. (KONTROLLO NESE JE ME cm!)"))
    )
    (princ (strcat "\nNo polylines were found in layer \"" layer "\"."))
  )

  (princ)
)

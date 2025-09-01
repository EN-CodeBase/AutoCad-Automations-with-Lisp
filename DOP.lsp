(defun c:DOP (/ ptList rawPts ptStart ptEnd adjPt dx dy) ;DOP - draw orthogonal polyline
	(setq ptList nil)
	
	(while (setq pt (getpoint "\nPick Point (Enter to finish): "))
		(setq rawPts (append rawPts (list pt)))
	)
	
	(if (< (length rawPts) 2)
		(progn
			(princ "\nNeed at least 2 points!")
			(exit)
		)
	)
	; erlis the best fr fr
	(setq ptList (list (car rawPts)))

	(foreach ptEnd (cdr rawPts)
		(setq ptStart (last ptList))
		(setq dx (abs (- (car ptEnd) (car ptStart))))
		(setq dy (abs (- (cadr ptEnd) (cadr ptStart))))

		(if (> dx dy)
			(setq adjPt (list (car ptEnd) (cadr ptStart) 0.0))

			(setq adjPt (list (car ptStart) (cadr ptEnd) 0.0))
		)

		(setq ptList (append ptList (list adjPt)))
	)

	(apply 'command (cons "PLINE" ptList))
	(command "")

	(princ)
)








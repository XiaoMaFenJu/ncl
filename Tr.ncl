begin

f = addfile("/mnt/hgfs/linux share/Tr.grib", "r")
print(f)

T_r = f->T_GDS0_ISBL
R_t = f->R_GDS0_ISBL
; printVarSummary(T_r)

; initial_time0 = f->initial_time0
; print(initial_time0)

; levels = f->lv_ISBL1

T_t = T_r - 272.15
copy_VarCoords(T_r, T_t)

T_tj = T_t(12:36,:,{39},{117})
R_tj = R_t(12:36,:,{39},{117})

T_tj!0 = "time"
T_tj!1 = "lev"
T = T_tj(lev|:,time|:)
R_tj!0 = "time"
R_tj!1 = "lev"
R = R_tj(lev|:,time|:)


wks_type = "png"
wks_type@wkHeight = 2500
wks_type@wkWidth = 2500

wks = gsn_open_wks(wks_type, "TR")

res1 = True
res2 = True

res1@gsnDraw = False
res1@gsnFrame = False

res1@trYReverse            = True

res1@tmXBMode = "explicit"
res1@tmXBLabelsOn = True
res1@tmXBValues = (/1946172,1946176,1946180,1946184,1946188,1946192,1946196/)
res1@tmXBLabels = (/"    12:00~C~2022/01/07","16:00","20:00","00:00","04:00","08:00","12:00"/)
res1@tmXBLabelFontHeightF = 0.015;font size

res1@tmYLMode = "explicit"
res1@tmYLLabelsOn = True
levels = ispan(1000, 850, 10)
res1@tmYLValues = levels
res1@tmYLLabels = tostring(levels)
res1@tmYLLabelFontHeightF = 0.015;font size

res1@cnLevelSelectionMode = "Explicitlevels"
res1@cnLevels = (/60,70/)

res2@cnInfoLabelOn = False
res2@cnLineLabelAngleF = 0
res2@cnLineLabelDensityF = 1.5
res2@cnLineThicknessF = 1.5
; res@cnLineLabelFontHeightF = 0.01



res2@gsnDraw = False
res2@gsnFrame = False
res2@cnInfoLabelOn = False

res1@cnFillOn = True
res1@cnFillPalette = (/"white","grey80","grey60"/)
res1@cnLinesOn = False
res1@gsnLeftString = ""
res1@gsnRightString = ""

res1@lbBoxEndCapStyle = "TriangleBothEnds"
res1@lbLabelFontHeightF = 0.01

res1@pmLabelBarOrthogonalPosF = -0.02
res1@pmLabelBarParallelPosF = 0.5
res1@pmLabelBarWidthF = 0.2;colorbar width
res1@pmLabelBarHeightF = 0.07;colorbar height

line = gsn_csm_contour(wks, T, res2)
tianse = gsn_csm_contour(wks, R, res1)

overlay(tianse, line)
draw(tianse)
frame(wks)

end
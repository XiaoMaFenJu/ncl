begin

f = addfile("/home/xiaoma/nc/minhang0403/adaptor.mars.internal_1.grib", "r")
print(f)

g0_lat_2 = f->g0_lat_2
; printVarSummary(g0_lat_2)
; g0_lon_3 = f->g0_lon_3
; printVarSummary(g0_lon_3)
levels = f->lv_ISBL1
print(levels)

initial_time0_hours = f->initial_time0_hours
; print(initial_time0_hours)

; a = cd_calendar(initial_time0_hours,4)
; initial_time0_encoded = f->initial_time0_encoded
; print(initial_time0_encoded)
initial_time0 = f->initial_time0
print(initial_time0)
; print(W_GDS0_ISBL(:,0,0,0))
; print(a)

W = f->W_GDS0_ISBL;TIME LEVEL LAT LON
U = f->U_GDS0_ISBL
V = f->V_GDS0_ISBL

W!0 = "time"
W!1 = "lev"
W!2 = "lat"
W!3 = "lon"
w_t = W(lev|:,time|:,lat|:,lon|:)
U!0 = "time"
U!1 = "lev"
U!2 = "lat"
U!3 = "lon"
u_t = U(lev|:,time|:,lat|:,lon|:)
V!0 = "time"
V!1 = "lev"
V!2 = "lat"
V!3 = "lon"
v_t = V(lev|:,time|:,lat|:,lon|:)
printVarSummary(w_t)

wspd_t = u_t
wspd_t = (/ sqrt(u_t^2+v_t^2) /)





wks_type = "png"
wks_type@wkHeight = 2500
wks_type@wkWidth = 2500

wks = gsn_open_wks(wks_type, "wind")

res = True
res@gsnFrame = False
res@gsnDraw = False

res@vcMonoLineArrowColor = True;arrowcolor
res@vcFillArrowsOn = True
res@vcFillArrowEdgeColor = "black"
res@vcFillArrowEdgeThicknessF = 1
res@vcRefMagnitudeF = 10;ref value
res@vcRefLengthF = 0.018;ref length
res@vcMinDistanceF = 0.02;mindistance
res@vcMapDirection = False
res@gsnLeftString = ""
res@gsnRightString = ""

; res@trXMaxF = 3.5
; res@trXMinF = -0.5

; res@tmXBOn = False
; res@tmYLOn = False

res@vcRefAnnoSide = "Right";position of refanno
res@vcRefAnnoParallelPosF = 0.1;me too
res@vcRefAnnoOrthogonalPosF = 0.05;me toooo
res@vcRefAnnoFontHeightF = 0.013
res@lbLabelBarOn = False
;(/8,7,6,5,4,3,2,1,0/)
plot = gsn_csm_vector_scalar(wks, u_t(:,36:60,{39},{117}), v_t(:,36:60,{39},{117}),wspd_t(:,36:60,{39},{117}), res)

cnres = True
cnres@gsnFrame = False
cnres@gsnDraw = False

cnres@tmXBMode = "explicit"
cnres@tmXBLabelsOn = True
cnres@tmXBValues = (/1946172,1946176,1946180,1946184,1946188,1946192,1946196/)
cnres@tmXBLabels = (/"    12:00~C~2022/01/07","16:00","20:00","00:00","04:00","08:00","12:00"/);
cnres@tmXBLabelFontHeightF = 0.013;font size

cnres@tmYLMode = "explicit"
cnres@tmYLLabelsOn = True
cnres@tmYLValues = levels((/9,8,7,6,5,4,3,2,1,0/))
cnres@tmYLLabels = tostring(levels((/9,8,7,6,5,4,3,2,1,0/)));
cnres@tmYLLabelFontHeightF = 0.013;font size
cnres@trYReverse            = True ;fanzhuan z zhou

cnres@cnLineLabelsOn = False
cnres@cnLinesOn = False
cnres@cnFillOn = True
cnres@cnInfoLabelOn = False

cnres@gsnLeftString = ""
cnres@gsnRightString = ""

cnres@lbBoxEndCapStyle = "TriangleBothEnds"
cnres@lbLabelFontHeightF = 0.01

cnres@pmLabelBarOrthogonalPosF = -0.04
cnres@pmLabelBarParallelPosF = 0.5
cnres@lbBoxMinorExtentF = 0.2;colorbar width
cnres@pmLabelBarHeightF = 0.1;colorbar height

cnres@cnLevelSelectionMode = "ManualLevels"
cnres@cnMinLevelValF = -0.32
cnres@cnMaxLevelValF = 0.32
cnres@cnLevelSpacingF = 0.04

cnres@cnFillPalette = "BlueRed"

plot1 = gsn_csm_contour(wks, w_t(:,36:60,{39},{117}), cnres)
overlay(plot1, plot)

draw(plot1)
frame(wks)


end
begin

fw = addfile("/home/xiaoma/nc/minhang0403/water.grib", "r")
print(fw)
initial_time0 = fw->initial_time0
print(initial_time0)

ff = addfile("/home/xiaoma/nc/minhang0403/wind.grib", "r")
print(ff)
initial_time1 = ff->initial_time0
print(initial_time1)

water_t = fw->IE_GDS0_SFC
U_t = ff->U_GDS0_ISBL
V_t = ff->V_GDS0_ISBL

water = water_t(2:5,:,:)
U = U_t(10:13,{1000},:,:)
V = V_t(10:13,{1000},:,:)

printVarSummary(U)

maxlat = 40.5
maxlon = 118.5
minlat = 38.25
minlon = 116.25
time = 0
stringleft = "01/07 22:00"

wks_type = "png"
wks_type@wkHeight = 2500
wks_type@wkWidth = 2500
wks = gsn_open_wks(wks_type,"waterflux22")

vcres = True
vcres@gsnFrame = False
vcres@gsnDraw = False

vcres@vcMonoLineArrowColor = True;arrowcolor
vcres@vcFillArrowsOn = True
vcres@vcFillArrowEdgeColor = "black"
vcres@vcFillArrowEdgeThicknessF = 0.5
vcres@vcRefMagnitudeF = 10;ref value
vcres@vcRefLengthF = 0.022;ref length
vcres@vcMinDistanceF = 0.026;mindistance
; vcres@vcMapDirection = False
vcres@gsnLeftString = stringleft
vcres@gsnRightString = ""
vcres@vcRefAnnoString2 = ""

; res@trXMaxF = 3.5
; res@trXMinF = -0.5

; res@tmXBOn = False
; res@tmYLOn = False

vcres@vcRefAnnoSide = "Right";position of refanno
vcres@vcRefAnnoParallelPosF = 0.1;me too
vcres@vcRefAnnoOrthogonalPosF = -0.05;me toooo
vcres@vcRefAnnoFontHeightF = 0.013
vcres@lbLabelBarOn = False

vector  = gsn_csm_vector(wks,U(time,{minlat:maxlat},{minlon:maxlon}),V(time,{minlat:maxlat},{minlon:maxlon}),vcres)

cnres = True
cnres@gsnFrame = False
cnres@gsnDraw = False

cnres@cnLevelSelectionMode = "ManualLevels"
cnres@cnMinLevelValF = -0.000015
cnres@cnMaxLevelValF = 0.000015
cnres@cnLevelSpacingF = 0.000001

cnres@cnLineLabelsOn = False
cnres@cnInfoLabelOn = False
cnres@gsnLeftString = ""
cnres@gsnRightString = ""
cnres@cnFillOn = True
cnres@cnFillPalette = "MPL_gist_gray"
cnres@cnLinesOn = False

cnres@lbBoxEndCapStyle = "TriangleBothEnds"
cnres@lbLabelFontHeightF = 0.01

cnres@pmLabelBarOrthogonalPosF = -0.02
cnres@pmLabelBarParallelPosF = 0.5
cnres@lbBoxMinorExtentF = 0.2;colorbar width
cnres@pmLabelBarHeightF = 0.1;colorbar height


contour = gsn_csm_contour(wks, water(time,{minlat:maxlat},{minlon:maxlon}), cnres)

mpres = True
mpres@gsnFrame = False
mpres@gsnDraw = False
mpres@mpMaxLatF = maxlat
mpres@mpMinLatF = minlat
mpres@mpMaxLonF = maxlon
mpres@mpMinLonF = minlon
mpres@mpDataBaseVersion = "Ncarg4_1" 
mpres@mpDataSetName = "Earth..4"
mpres@mpFillColor = "white"

mpres@mpOutlineOn=True
mpres@mpOutlineSpecifiers = (/"China:Tianjin Shi","Mongolia","China"/)
mpres@mpGeophysicalLineThicknessF = 4
mpres@mpProvincialLineThicknessF = 4
mpres@mpProvincialLineColor = "blue"
mpres@tmXBLabelFontHeightF = 0.015
mpres@pmTickMarkDisplayMode   ="Always"

map = gsn_csm_map(wks, mpres)

overlay(map, contour)
overlay(map, vector)
draw(map)
frame(wks)

end
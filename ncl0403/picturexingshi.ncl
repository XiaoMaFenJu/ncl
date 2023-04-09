begin

f = addfile("/home/xiaoma/nc/minhang0403/pressure.grib", "r")


print(f)

G_t = f->Z_GDS0_ISBL
G = G_t/100
copy_VarCoords(G_t, G)


initial_time0 = f->initial_time0
print(initial_time0)
levels = f->lv_ISBL1
print(levels)

;;;;;plot;;;;;
wks_type = "png"
wks_type@wkHeight = 2500
wks_type@wkWidth = 2500
wks = gsn_open_wks(wks_type,"850")
res = True

res@gsnAddCyclic = False
res@mpMaxLatF = 53
res@mpMinLatF = 10
res@mpMinLonF = 90
res@mpMaxLonF = 135

res@cnInfoLabelOn = False
res@cnLineThicknessF = 3
res@cnLineLabelBackgroundColor = "white"
res@cnLineLabelAngleF = 0
res@cnLineLabelFontHeightF = 0.01

res@cnLineLabelDensityF = 1.5
res@mpDataBaseVersion = "Ncarg4_1" 
res@mpDataSetName = "Earth..4"

res@mpOutlineOn=True
res@mpOutlineSpecifiers = (/"China:Tianjin Shi","Mongolia","China"/)

res@mpProvincialLineThicknessF = 2
res@mpProvincialLineColor = "blue"

res@gsnRightString = ""
res@tiMainFontHeightF = 0.018

;;;;;change
res@cnLevelSelectionMode = "Explicitlevels"
res@cnLevels = (/138,139,140,141,142,143,144,145,146,147,148,149,150,151,152/)
res@gsnLeftString = "850hPa"
res@gsnLeftStringFontHeightF = 0.017
plot = gsn_csm_contour_map_ce(wks, G(1,{850},:,:), res)



end

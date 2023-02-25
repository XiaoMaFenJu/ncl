begin
;read data
data_all_one = new((/2,124,51/),"float")
data_all = new((/12,124,50/),"float");create new varible
month = (/"01","02","03","04","05","06","07","08","09","10","11","12"/)

do i = 0,11,1
file_path = "nc/0413/yn124std/r" + month(i) + "-1961n.dat"
if (i .eq. 1 .or. i .eq. 0) then
data_all_one(i,:,:) = asciiread(file_path,(/124,51/), "float")
data_all(i,:,:) = data_all_one(i,:,0:49)
else
data_all(i,:,:) = asciiread(file_path,(/124,50/), "float")
end if
end do

data = data_all(0,0:9,1)
stations = data_all(0,0:9,0)

sts_num = tostring_with_format(stations, "%5.0f")
x = fspan(0.5,9.5,10)

wks = gsn_open_wks("png", "test1")
res = True
res@gsnXYBarChart = True
res@trYMaxF = 8
res@trXMinF = 0
res@trXMaxF = 10
res@tiYAxisString = "(mm)"
res@tiMainString = "Precipitation of 10 stations in Yunnan province in 1961"
res@tiMainFontHeightF = 0.02

;ref line and colors/patterns
res@gsnYRefLine = 0
;res@gsnAboveYRefLineBarColors = (/"navy","blue","SkyBlue","SlateBlue"/)
;res@gsnBelowYRefLineBarColors = (/"firebrick","red","orange","green"/)
;res@gsnAboveYRefLineBarPatterns = (/0,1,2,3/)
;res@gsnBelowYRefLineBarPatterns = (/4,6,8,7/)

;x line
res@tmXBMode = "explicit"
res@tmXBLabelsOn = True
res@tmXBValues = fspan(0.5,9.5,10)
res@tmXBLabels = sts_num;(/56778,56772,56863,56871,56882,56880,56881,56785,56775,56872/)
res@tmXBLabelFontHeightF = 0.013;font size

;setting
res@gsnXYBarChartFillOpacityF = 0.9;toumingdu
res@gsnXYBarChartColors = (/"firebrick","red","orange","green","navy","blue","SkyBlue","SlateBlue"/);filling colors
res@gsnXYBarChartPatterns2 = (/0,5,1,3,4,17/);filling styles
res@gsnXYBarChartOutlineOnly = False;true is only the outline
res@gsnXYBarChartBarWidth = 0.8;out of range will be x or y
res@gsnXYBarChartFillDotSizeF = 0.01
res@gsnXYBarChartFillScaleF = 2
res@gsnXYBarChartFillLineThicknessF = 5

plot = gsn_csm_xy(wks, x, data, res)

end
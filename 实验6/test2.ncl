begin

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

data = data_all(:,:,1:49)
;print(data(0,:,:))

avg_month = dim_avg_n(data,2)
data_choose = avg_month(:,0:2)

data_choose!0 = "mon"
data_choose!1 = "sta"
data_p = data_choose(sta|:,mon|:)
x = ispan(0,11,1)

wks = gsn_open_wks("png", "test2")
res = True
res@gsnXYBarChart = True
res@trYMaxF = 280
res@trYMinF = 0
res@trXMaxF = 12.4
res@trXMinF = 0.1

;x line
res@tmXBMode = "explicit"
res@tmXBLabelsOn = True
res@gsnFrame = False
res@gsnDraw = True
res@tmXBValues = fspan(0.75,11.75,12)
res@tmXBLabels = (/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)
res@tmXBLabelFontHeightF = 0.013;font size

res@gsnYRefLine = 0
res@gsnXYBarChartBarWidth = 0.25
res@tiMainString = "The climatic average precipitation of three stations in Yunnan Province"
res@tiMainFontHeightF = 0.02
res@tiYAxisString = "(mm)"

res@gsnXYBarChartColors = (/"red"/)	
plot1 = gsn_csm_xy(wks,fspan(0.5,11.5,12),data_p(0,:),res)
res@gsnXYBarChartColors = (/"green"/)
plot2 = gsn_csm_xy(wks,fspan(0.75,11.75,12),data_p(1,:),res)
res@gsnXYBarChartColors = (/"blue"/)
plot3 = gsn_csm_xy(wks,fspan(1,12,12),data_p(2,:),res)

lbres                    = True          ; labelbar only resources
lbres@vpWidthF           = 0.3           ; labelbar width
lbres@vpHeightF          = 0.1           ; labelbar height
lbres@lbBoxMajorExtentF  = 0.36          ; puts space between color boxes
lbres@lbFillColors       = (/"red","green","blue"/)
lbres@lbMonoFillPattern  = True          ; Solid fill pattern
lbres@lbLabelFontHeightF = 0.035         ; font height. default is small
lbres@lbLabelJust        = "CenterLeft"  ; left justify labels
lbres@lbPerimOn          = False
lbres@lgPerimColor 	 = "white"
lbres@lbLabelFontHeightF = 0.016
labels = (/"56778","56772","56863"/)
gsn_labelbar_ndc(wks,3,labels,0.55,0.13,lbres)	; draw right labelbar column
; overlay(plot1,plot2)
; overlay(plot1,plot3)
; draw(plot1)
frame(wks)

end
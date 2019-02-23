# Kostis Dimos
# Zurich 2016

clearinfo
form Give directory and tier numbers:
	#comment insert read directory:
	#sentence directory /Users/Kostis/Desktop/exp
	comment Give your dependent variable:
	text xcol meal
	comment Give your independent variable:
	text ycol tip
endform

### Get mean of the two variables ###

mean_y = Get mean... 'ycol$'
mean_x = Get mean... 'xcol$'

### Get the SSE, the slope, and the y-intercept ###

nRows = Get number of rows
sst_x = 0
sst_y = 0
sse = 0
b1_num = 0

for i from 1 to nRows
	y = Get value... i 'ycol$'
	x = Get value... i 'xcol$'
	sub_y = y - mean_y
	sub_x = x - mean_x
	sst_y += sub_y^2
	sst_x += sub_x^2
	b1_num += sub_x*sub_y
endfor

b1 = b1_num / sst_x
b0 = mean_y - b1 * mean_x

for i from 1 to nRows
	y = Get value... i 'ycol$'
	x = Get value... i 'xcol$'
	y_pred = b1*x + b0
	sse += (y - y_pred)^2
endfor

ssr = sst_y - sse
r2 = ssr / sst_y
appendInfoLine: "mean ", ycol$, ": ", mean_x
appendInfoLine: "mean ", xcol$, ": ", mean_y
appendInfoLine: "intercept: ", b0, " slope: ", b1
appendInfoLine: "sst ", sst_y
appendInfoLine: "sse " ,sse 
appendInfoLine: "r-squared:", " ", fixed$ (r2, 3)

Erase all
Scatter plot... 'ycol$' 0 0 'xcol$'  0 0 'xcol$' 12 1

# END

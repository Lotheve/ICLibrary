##ICLibrary

该项目是个人在平时开发学习中对一些常规控件及API做的自定义封装汇总，一来便于今后开发需要，二来也是对自己平时积累的总结和巩固。所有封装文件位于ICLibrary目录，每一个封装的控件或者API都会在项目中给出Demo，灰常欢迎童鞋们任何的批评指正~该项目将持续更新！！

##封装控件&API

###Additions（基于系统类的类别扩展）

- **UIAlertView+Additions**
	
	支持Block回调模式的UIAlertView扩展类
	
- **UIButton+Additions**

	用于调整按钮文本与图片对其方式的UIButton扩展类

###CustomUI（基于系统控件的自定义控件封装）

- **ICButton**

		1.图片和文字同时存在的Button,可随意改变图片和文字的位置。
		2.常用的自定义圆角边界按钮等。
	
- **ICDatePicker**

		1.只有年份或只有月份的日期选择器,有确定取消按钮。
		2.只有年份和月份的日期选择器,有确定取消按钮。
	
-	**ICDoubleColumnPicker**

		1.自定义标题的双列数据选择器。
		2.自定义标题的双列有依赖关系或没有依赖关系的选择器。
	
-  **ICLabel**

		1.可指定range设置文本删除线的Label
 		2.可指定range设置文本颜色的Label
 		3.可指定range设置文本字体的Label
 	
- **ICPageControl**

		可改变点的颜色，大小，点之间的间距的PageControl。
	
- **ICProgressView**

		可改变粗度的进度条控件
	
- **ICCircleScrollBanner**

		1.可无限循环滚动的图片轮播视图，支持点击和滑动
		2.支持block形式回调
		3.支持本地图片和网络图片（基于SDWebImage）
- **ICSingleColumnPicker**

		单列数据选择器，支持自定义标题
		
- **ICTextField**

		1.使用自定义颜色大小的默认提示文字。
		2.可方便改变文字离左右边界的间距。
		3.可方便设置TextField左右自定义视图。
		
- **ICTextView**

		支持设置占位符的TextView
		
- **ICWebView**

		1.可根据内容调节高度的WebView控件
		2.支持block形式回调


###DeviceTool（自定义工具类封装）

- **ICMediaPickerHelper**

		媒体获取工具类，支持从相册获取和从摄像头获取照片/视频（要通过摄像头获取请在真机调试）
		
- **ICAddressBookHelper**
	
		获取手机的通讯录联系人信息的工具类，支持获取未排序数据和已分组数据
		
- **ICAudioRecorder**

		封装好的录音工具类，支持开始、暂停、停止
		
- **ICCalendarEventHelper**

		日历事件工具类
		1.可获取日历时间信息
		2.可向日历中添加事件
		
- **ICCommunicationHelper**

		调用设备拨号、发送短信、发送邮件的工具类
		
- **ICDeviceInfoHelper**

		获取设备用户名,设备系统名,系统版本,是否IPhone等的工具类
		
- **ICMutiAlbum**

		自定义的支持多选的相册
		
- **ICQRCodeRecognizer**

		iOS7基于AVFoundation实现的二维码识别器
		
- **ICSimpleCamera**

		基于AVFoundation实现的简易相机
		支持设置照片质量、闪光灯开关、前后摄像头切换
		

###其他

- **ICMacros**

		宏定义头文件




	












# onscripter-jh-miyoo-flip
[WIP] My ONScripter-jh Miyoo Flip port

## Original ONScripter-Jh readme
```
ONScripter是一个开源的NScripter脚本解释工具，主要由Ogapee开发维护
原版的Readme请查看Readme.old。

这是一个修改版的ONScripter源码，在GPLv2协议下发布，使用时请遵守。

修改目标：
	提供比原版ONScripter更好的性能，适当增加一些功能
	添加中文支持
	尽可能的兼容原版ONS脚本
	
进度

	SDL2分支提供各种改进并可在SDL2环境编译
	目前Windows、Android、iOS、Linux、Windows Phone平台均编译通过实测可用，其余平台未测试
```

## [WIP] How to Build  
* Modify Makefile, where are gcc and stage_files   
* Run 'make clean && make MIYOO=1'  

## Cross compile gcc toolchain and SDK stage files    
* aarch64-buildroot-linux-gnu_sdk-buildroot.tar.gz  
from rg351p-toolchain,  
https://github.com/AdrienLombard/sm64-351elec-port/releases/tag/v1.0.0  

## TODO and bugs   
* Check key map  
* (TODO) Start key can't enter auto mode.  

## miyoo flip adb usage  
* killall -KILL MainUI runmiyoo.sh
```
我试过可以成功获取到Miyoo Flip的adb（接掌机底部u口），
方法是只要换个U口就可以了，我是用usb hub而不是直接接PC。
我怀疑RK3566对u口电压要求可能要比全志的更高，
如果差点就会adb驱动失败。显示提示符rk3566-buildroot，
也可以通过killall -KILL MainUI runmiyoo.sh关闭界面。
Linux rk3566-buildroot 5.10.160，内存是1g。
至于utg 网口，我试过不行，用无线连ssh似乎也不行，
所以只能用adb了

我测试过，可以用类似r36s和rgb10x的方式编译aarch版的
onscripter-jh运行在miyoo flip上，不过有一点小区别是不自带
libbz2动态库（libbz2.so.1.0），
所以需要这样才能正常运行：
LD_LIBRARY_PATH=/mnt/sdcard/App/pixel-reader/lib/ ./onscripter ​​​
（补充，也缺libjpeg，而且SDL_image工作也显示不了jpeg）

```

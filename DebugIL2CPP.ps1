#Путь до версии юнити
$unityPath = 'C:\Program Files\Unity\Hub\Editor\2020.3.18f1';
#Путь до NDK, не меняется
$ndkDebugger ='\Editor\Data\PlaybackEngines\AndroidPlayer\NDK\toolchains\aarch64-linux-android-4.9\prebuilt\windows-x86_64\bin\aarch64-linux-android-addr2line.exe';

$app = $unityPath + $ndkDebugger;

#Каталог распакованных дебаг.символов
$symbolsPath = 'C:\Builds\BladeStorm\Android\BS_dev-0.0.1-v1.symbols\arm64-v8a\';

$symbolsName = 
'libil2cpp.sym.so' #Код проекта
#'libunity.sym.so' #Юнити библиотеки

$symbolPath = $symbolsPath + $symbolsName

#Блок памяти 
#- явноё указание
#$memoryBlockNumber = 0x2680b04
#$memoryBlock = $$memoryBlockNumber.ToString('X')


#2021.09.09 19:07:45.177 31782 31812 Error AndroidRuntime 	at libil2cpp.0x13bfef0(Native Method)
#2021.09.09 19:07:45.177 31782 31812 Error AndroidRuntime 	at libil2cpp.0x10cfdac(Native Method)
#Вариант для ленивых, просто вставьте сюда лог из LogCat
$logString = '2021.09.09 19:07:45.177 31782 31812 Error AndroidRuntime 	at libil2cpp.0x10cfdac(Native Method)'
#
$regExp = 'libil2cpp\.0x((\w)+)\('
$res = [regex]::Match($logString, $regExp).captures.groups[1].value
$memoryBlock = '0x' + $res

$args = '-C', '-f', '-e',  $symbolPath, $memoryBlock

& $app $args
#2021.08.27 17:47:09.815 1188 1274 Error AndroidRuntime 	at libil2cpp.0x43696f4(Native Method)

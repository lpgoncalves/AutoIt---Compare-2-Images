#CS
		Name: 				Compare Images UDF
		Developer: 			Timothy Bomer
		Company: 			Amarok Studios
		Date:				03/15/2017
		Develop Date:		09/18/2016
		
		Description:		Compare two images to see if they are the same.
#CE

; Includes
#Include <GDIPlus.au3>

; Compare Images, Called with the two images as parameters.
Func _CompareImages($ciImageOne, $ciImageTwo)
	; Initialize GDIPlus
	_GDIPlus_Startup()
	
	$fname1=$ciImageOne
	; If the first file name is empty, exit.
	If $fname1="" Then
		MsgBox(16, "Compare Images Error", "File 1 is empty!")
		Exit
	EndIf
	$fname2=$ciImageTwo
	; If the second file name is empty, exit.
	If $fname2="" Then
		MsgBox(16, "Compare Images Error", "File 2 is empty!")
		Exit
	EndIf
	; Load the bitmaps into a variable.
	$bm1 = _GDIPlus_ImageLoadFromFile($fname1)
	$bm2 = _GDIPlus_ImageLoadFromFile($fname2)

	; Compare Images
	Return CompareBitmaps($bm1, $bm2)
EndFunc

Func CompareBitmaps($bm1, $bm2)
    $Bm1W = _GDIPlus_ImageGetWidth($bm1)
    $Bm1H = _GDIPlus_ImageGetHeight($bm1)
    $BitmapData1 = _GDIPlus_BitmapLockBits($bm1, 0, 0, $Bm1W, $Bm1H, $GDIP_ILMREAD, $GDIP_PXF32RGB)
    $Stride = DllStructGetData($BitmapData1, "Stride")
    $Scan0 = DllStructGetData($BitmapData1, "Scan0")

    $ptr1 = $Scan0
    $size1 = ($Bm1H - 1) * $Stride + ($Bm1W - 1) * 4


    $Bm2W = _GDIPlus_ImageGetWidth($bm2)
    $Bm2H = _GDIPlus_ImageGetHeight($bm2)
    $BitmapData2 = _GDIPlus_BitmapLockBits($bm2, 0, 0, $Bm2W, $Bm2H, $GDIP_ILMREAD, $GDIP_PXF32RGB)
    $Stride = DllStructGetData($BitmapData2, "Stride")
    $Scan0 = DllStructGetData($BitmapData2, "Scan0")

    $ptr2 = $Scan0
    $size2 = ($Bm2H - 1) * $Stride + ($Bm2W - 1) * 4

    $smallest = $size1
    If $size2 < $smallest Then $smallest = $size2
    $call = DllCall("msvcrt.dll", "int:cdecl", "memcmp", "ptr", $ptr1, "ptr", $ptr2, "int", $smallest)



    _GDIPlus_BitmapUnlockBits($bm1, $BitmapData1)
    _GDIPlus_BitmapUnlockBits($bm2, $BitmapData2)
	
	_GDIPlus_ImageDispose($bm1)
	_GDIPlus_ImageDispose($bm2)
	_GDIPlus_Shutdown()

    Return ($call[0]=0)


EndFunc  ;==>CompareBitmaps
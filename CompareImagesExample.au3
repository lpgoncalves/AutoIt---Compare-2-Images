#Include "CompareImagesUDF.au3"

; Define the two images (They can be different file formats)
$img1 = "image1.jpg"
$img2 = "image2.jpg"

; Compare the two images
$duplicateCheck = _CompareImages($img1, $img2)
MsgBox(0,"Is Duplicate?", $duplicateCheck)
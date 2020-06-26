/*
$ java -jar scalastyle_2.12-1.0.0-batch.jar --config scalastyle-config.xml
diegoaa.scala -q #linting
Processed 1 file(s)
Found 0 errors
Found 0 warnings
Finished in 646 ms
$ scalac diegoaa.scala #compilation
*/

import scala.io.Source
object diegoaa extends App {
  val source = Source.fromFile("DATA.lst").getLines.toArray
  val alphabetArray = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567".toArray

  def encode(value: String): String = {
    var message = padding(value)
    var binary = ""
    message.map(_.toByte).foreach {e =>
      binary = binary + convertDecimalToBinary(e)
    }
    var result = ""
    for(i <- 0 until binary.length by 5) {
      var decimal = Integer.parseInt(binary.slice(i,i + 5), 2)
      result = result + alphabetArray(decimal)
    }
    return result
  }

  def decode(value: String): String = {
    val decode = value.toArray
    var bin = new Array[String](decode.length)
    for(i <- 0 until decode.length) {
      var alphabetChar = alphabetArray.indexOf(decode(i))
      bin(i) = convertDecimalToBinary(alphabetChar).slice(3,8)
    }
    val binToString = bin.mkString("")
    var result = ""
    for(i <- 0 until binToString.length by 8) {
      var decimal = Integer.parseInt(binToString.slice(i,i + 8), 2)
      result = result + Character.toString(decimal.asInstanceOf[Char])
    }
    return removePadding(result)
  }

  def removePadding(value: String): String = {
    return value.dropRight(value.takeRight(1).toInt)
  }

  def padding(value: String): String = {
    var withPadding = ""
    var reminder = value.length%5
    if (reminder != 0){
      var missedValues =  5 - reminder
      var padding = missedValues.toString * missedValues
      withPadding = value + padding
    }
    else {
      withPadding = value + "55555"
    }
    return withPadding
  }

  def convertDecimalToBinary(num: Int): String = {
    var binary = Integer.toString(num, 2)
    if (binary.length < 8){
      val reminder = binary.length%8
      val missedValues =  8 - reminder
      val padding = "0" * missedValues
      binary = padding + binary
    }
    return binary
  }

  for(i <- 0 until source(0).toInt) {
    var message = source(i + 1)
    if ((i + 1)%2 != 0) {
      print(encode(message) + " ")
    }
    else {
      print(decode(message) + " ")
    }
  }
}

/*
$ scala diegoaa
OBQXE4TPOQ2DINBU induced rejuvenation MVTGMZLSOZSXGY3FNZ2DGMZT delectation
cuddlier pasty OVXGSY3ZMNWGK4ZAMZXXE3LVNRQWKIDXOJSXG5DMNFXGOIDMNFTWQ5DIMVQ
WIZLEGU2TKNJV perfect reappearances
*/

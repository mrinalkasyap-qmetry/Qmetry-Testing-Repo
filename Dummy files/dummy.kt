fun main (args: Array<String>){  
    try {  	
        val data =  9/ 0  
        println(data)  
    } catch (e: ArithmeticException) {  
        println(e)  
    } finally {  
        println("finally block executes")  
    }  
    println("write next code")  
}  

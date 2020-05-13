CLASS ycl_generate_language_data_13 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_generate_language_data_13 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA:itab TYPE TABLE OF ylanguage_13.


*   read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

*   fill internal travel table (itab)
    itab = VALUE #(
  ( mykey = '02D5290E594C1EDA93815057FD946624'
    l_id = '1'
    l_name = 'Java'
    l_description = 'Application, business, client-side, general, mobile development, server-side, web'
    l_snippet = 'class HelloWorld {  static public void main( String args[] ) {    System.out.println( "Hello World!" );  }}'
    l_rating = '5'
    l_ide = 'Eclipse, IntelliJ IDEA, NetBeans'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Java_(Programmiersprache) ' )
  ( mykey = '02D5290E594C1EDA93815C50CD7AE62A'
    l_id = '2'
    l_name = 'C++'
    l_description = 'Application, system'
    l_snippet = '#include <iostream.h>main(){    cout << "Hello World!" << endl;    return 0;}'
    l_rating = '3'
    l_ide = 'DEV C++, Visual Sudio Code, Code::Blocks'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/C%2B%2B ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB0B'
    l_id = '3'
    l_name = 'Python'
    l_description = 'Application, general, web, scripting, artificial intelligence, scientific computing'
    l_snippet = 'print("Hello World")'
    l_rating = '5'
    l_ide = 'Eclipse + Pydev, Pycharm, Visual Studio Code'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Python_(Programmiersprache) ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB1B'
    l_id = '4'
    l_name = 'JavaScript'
    l_description = 'Client-side, server-side, web'
    l_snippet = 'fun main(args : Array<String>) {    println("Hello, world!")}'
    l_rating = '2'
    l_ide = 'Visual Studio Code, Atom, Brackets'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/JavaScript ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB1D'
    l_id = '5'
    l_name = 'Ruby'
    l_description = 'Application, scripting, web'
    l_snippet = 'puts "Hello World!"'
    l_rating = '4'
    l_ide = 'Atom, VSCode, RubyMine'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Ruby_(Programmiersprache) ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB22'
    l_id = '6'
    l_name = 'Swift'
    l_description = 'Application, general'
    l_snippet = 'println("Hello, world!")'
    l_rating = '4'
    l_ide = 'AppCode, Xcode, Atom'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Swift_(Programmiersprache) ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB24'
    l_id = '7'
    l_name = 'Go'
    l_description = 'Application, web, server-side'
    l_snippet = 'package mainimport "fmt"func main() { fmt.Printf("Hello World\n")}  '
    l_rating = '4'
    l_ide = 'Visual Studio Code, LiteIDE, Eclipse with GoClipse'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Go_(Programmiersprache) ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB2A'
    l_id = '8'
    l_name = 'Haskell'
    l_description = 'Application'
    l_snippet = 'main = putStrLn "Hello World"'
    l_rating = '3'
    l_ide = 'Emacs, Visual Studio Code, Atom'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Haskell_(Programmiersprache)' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB2C'
    l_id = '9'
    l_name = 'Kotlin'
    l_description = 'Application, mobile development, server-side, client-side, web'
    l_snippet = 'fun main(args : Array<String>) { println("Hello, world!") }'
    l_rating = '4'
    l_ide = 'IntelliJ IDEA, Android Studio, Vim'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Kotlin_(Programmiersprache) ' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB3D'
    l_id = '10'
    l_name = 'Matlab'
    l_description = 'Highly domain-specific, numerical computing'
    l_snippet = 'disp("Hello World");'
    l_rating = '5'
    l_ide = 'Matlab IDE'
    l_favourite = ''
    l_wikipedia = ' https://de.wikipedia.org/wiki/Matlab ' )
  ).

*   delete existing entries in the database table
    DELETE FROM ylanguage_13.

*   insert the new table entries
    INSERT ylanguage_13 FROM TABLE @itab.

*   check the result
    SELECT * FROM ylanguage_13 INTO TABLE @itab.
        SORT itab BY l_id ASCENDING.


    out->write( sy-dbcnt ).
    out->write( 'Language data inserted successfully!').
  ENDMETHOD.
ENDCLASS.

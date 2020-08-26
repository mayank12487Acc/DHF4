xquery version '1.0-ml';

import module namespace test = 'http://marklogic.com/test' at '/test/test-helper.xqy';
import module namespace cf = "http://marklogic.com/roche/commonFunction" at "/Main_Project/lib/generateHeader.xqy";

let $a := cf:Generate_Header()
let $cd := fn:substring($a/creationDate/string(),1,10)
let $user := $a/User/string()

return
(
test:assert-equal("2020-08-24",$cd),
test:assert-equal("admin",$user)
);
xquery version "1.0-ml";

module namespace plugin = "http://marklogic.com/data-hub/plugins";
import module namespace cf = "http://marklogic.com/roche/commonFunction" at "/generateHeader.xqy";
declare namespace es = "http://marklogic.com/entity-services";

declare option xdmp:mapping "false";

(:~
 : Create Headers Plugin
 :
 : @param $id      - the identifier returned by the collector
 : @param $content - the output of your content plugin
 : @param $options - a map containing options. Options are sent from Java
 :
 : @return - zero or more header nodes
 :)
declare function plugin:create-headers(
  $id as xs:string,
  $content as item()?,
  $options as map:map) as node()*
{
  let $a := cf:Generate_Header()
return $a
};

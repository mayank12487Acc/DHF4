xquery version "1.0-ml";

module namespace plugin = "http://marklogic.com/data-hub/plugins";

declare namespace es = "http://marklogic.com/entity-services";

declare option xdmp:mapping "false";

(:~
 : Create Content Plugin
 :
 : @param $id          - the identifier returned by the collector
 : @param $options     - a map containing options. Options are sent from Java
 :
 : @return - your transformed content
 :)
declare function plugin:create-content(
  $id as xs:string,
  $options as map:map) as item()?
{
  let $doc := fn:doc($id)/es:envelope/es:instance/root
let $OrderN := xs:integer("00001")
let $Product := $doc/Product/string()
let $Price := $doc/ProductPrice/string()
let $QTY := $doc/Quantity/string()
let $total := xs:int($QTY) * xs:int($Price)
  return if ($doc) then 
  (<OrderH>
<OrderN>{$OrderN}</OrderN>
<OrderProductH>{$Product}</OrderProductH>
<ProductPriceH>{$Price}</ProductPriceH>
<OrderQTYH>{$QTY}</OrderQTYH>
<OrderTotalH>{$total}</OrderTotalH>
</OrderH>)
    else
      $doc
};

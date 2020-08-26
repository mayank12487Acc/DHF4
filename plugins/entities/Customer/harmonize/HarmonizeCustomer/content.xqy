xquery version "1.0-ml";

module namespace plugin = "http://marklogic.com/data-hub/plugins";

import module namespace es = "http://marklogic.com/entity-services"
at "/MarkLogic/entity-services/entity-services.xqy";

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
  $options as map:map) as map:map
{
  let $doc := fn:doc($id)
  let $source := $doc
  return
  plugin:extract-instance-Customer($source)
};
  
(:~
: Creates a map:map instance from some source document.
: @param $source-node  A document or node that contains
:   data for populating a Customer
: @return A map:map instance with extracted data and
:   metadata about the instance.
:)
declare function plugin:extract-instance-Customer(
$source as node()?
) as map:map
{

  (: the original source documents :)
  let $attachments := $source
  let $source      :=
    if ($source/*:envelope and $source/node() instance of element()) then
      $source/*:envelope/*:instance/node()
    else if ($source/*:envelope) then
      $source/*:envelope/*:instance
    else if ($source/instance) then
      $source/instance
    else
      $source
  (: These mappings were generated using mapping: MapCustomer, version: 0 on 2020-08-17T17:51:45.6204004+05:30. :)
  let $name := xs:string($source/Name)
  let $phone := xs:string($source/Phone)
  let $adress := xs:string($source/Adress)
  let $card_-details := xs:int($source/Card_Details)

  (: return the in-memory instance :)
  (: using the XQuery 3.0 syntax... :)
  let $model := json:object()
  let $_ := (
    map:put($model, '$attachments', $attachments),
    map:put($model, '$type', 'Customer'),
    map:put($model, '$version', '0.0.1'),
    map:put($model, 'Name', $name),
    map:put($model, 'Phone', $phone),
    map:put($model, 'Adress', $adress),
    map:put($model, 'Card_Details', $card_-details)
  )

  (: if you prefer the xquery 3.1 version with the => operator....
  https://www.w3.org/TR/xquery-31/#id-arrow-operator
  let $model :=
  json:object()
    =>map:with('$attachments', $attachments)
    =>map:with('$type', 'Customer')
    =>map:with('$version', '0.0.1')
      =>es:optional('Name', $name)
    =>es:optional('Phone', $phone)
    =>es:optional('Adress', $adress)
    =>es:optional('Card_Details', $card_-details)
  :)
  return $model
};

declare function plugin:make-reference-object(
$type as xs:string,
$ref as xs:string)
{
  let $o := json:object()
  let $_ := (
    map:put($o, '$type', $type),
    map:put($o, '$ref', $ref)
  )
  return
  $o
};
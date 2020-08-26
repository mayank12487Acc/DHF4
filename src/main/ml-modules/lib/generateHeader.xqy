xquery version "1.0-ml";
module namespace cf = "http://marklogic.com/roche/commonFunction";
declare function cf:Generate_Header()
{
  let $date := fn:true()
  return 
  <META_HEADER>
  <creationDate>{fn:current-date()}</creationDate>
  <User>{xdmp:get-current-user()}</User>
  </META_HEADER>
	};

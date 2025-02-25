<%
  '
  ' This supports redirection for WAP/WML clients.
  ' We check the Http_accept variable to see if it contains "wap". If it does, we redirect the request
  ' to WapDefault.asp. Using this method, an HTML browser or a cell phone could make the same URL
  ' request (http://localhost/DAW.Examples.Order11) and get the proper data served.
  '
  acceptString = Request.ServerVariables("HTTP_ACCEPT")
  If Instr(LCase(acceptString), "wap") > 0 Then
       Response.Redirect "WapDefault.asp"
  End if
  '
  ' else do the normal default.asp HTML behavior
  '
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; iso-8859-1">
<title>Data Entry and Report Example</title>
</head>

<frameset cols="20%,80%">
   <frame src="WebOrder_Content.asp" name="contents" marginwidth="1"
   marginheight="1" target="main">
   <frame src="WebOrder_Main.asp" name="main" marginwidth="1"
   marginheight="1">
   <noframes>
   <body>
   </body>
   </noframes>
</frameset>

</html>







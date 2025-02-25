<%
response.expires = 0

' When we log in we will set some cookies that can be used by
' ASP files within this application. These cookies will disappear
' when the browser is exited.
' We want to store the following cookies:
'   Rights = 0 | -1 | 1
'   User[name]      = user login name
'   User[Pass]      = user password
'   User[FullName]  = Full user name, from datafile


If request("Request_method")="POST" Then
    ' If this page was called via a POST it means that the ASP page called
    ' itself posting a user name and user password. We will get the name
    ' and password and pass it on to the VDF login BPO to check if it is valid.

    ' get posted information
    UserName = request.Form("User__Name")
    UserPass = request.Form("User__Pass")
    If UserPass<>"" and UserName<>"" then
       ' call VDF Login_User function. Return non-zero of login
       ' is ok.
       LoginOk = oLoginUsers.call("Get_Login_User",UserName,UserPass)
    else
       LoginOk = 0
    end if
    ' if login is ok, set browser login cookies.
    ' if login is not ok, clear cookies.
    ' Note valuefor Rights = 0 - not logged in yet
    '                        1 - login successful
    '                       -1 - attempted login failed
    If LoginOk <> 0 then
        response.cookies("User")("Name")=UserName
        response.cookies("User")("Pass")=UserPass
        response.cookies("User").Path="/"
        ' if login was OK the login BPO's DD file has the
        ' current user as its current record.
        response.cookies("User")("FullName")=oLoginUsers.ddValue("Users.Full_Name")
        response.cookies("User").Path="/"
        response.cookies("Rights")="1"
        response.cookies("Rights").Path="/"
        Rights = "1"
    else
        ' login failed, clear cookies.
        response.cookies("User")("Name")=""
        response.cookies("User")("Pass")=""
        response.cookies("User")("FullName")=""
        response.cookies("User").Path="/"
        response.cookies("Rights")="-1"
        response.cookies("Rights").Path="/"
        Rights = "-1"
    end if
else
    Rights = "0"
end if

' Note that cookies must be sent before the html header is started
%>

<html>
<head>
<meta http-equiv="Content-Type"
content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Login to the Accounting System</title>
<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If Rights = "1" then %>

<% ' If Rights is 1, login was ok. Display welcome message  %>


<h3>Login Successful</h3>
<br>
Welcome <%=request.cookies("User")("FullName")%>. You are now logged in at <%=now%>.<br>
You have full system rights.


<%else%>

<%
 ' If Rights is not 1, we must login. If rights is -1 we have an
 ' unsuccessful login attempt. If rights is 0 we have a first time login
 ' attempt. Display appropriate messages for each event.
 %>

<h3>Please login to the system</h3>

        <% If Rights = "0" then %>

<blockquote>
You will need to log into the system if you wish to add, edit or delete information.
You do not need to log into the system if you wish to view data. This capability
is extended to all of our guests
</blockquote>

        <% else %>

<center><strong>Invalid User Name or Password. Please try again</strong></center>
<blockquote>
Remember that even without logging in, you still have guest privleges and that you
may still view data.
</blockquote>

        <%end if%>

<form action="Login.asp" method="POST">
<blockquote>

<table border="0" class="EntryTable">
  <tr>
      <td class="Label">Enter User Name: (<em>hint:</em> Try "john")</td>
      <td><input type="text" size="10" name="User__Name" value="<%=UserName%>"></td>
  </tr>
  <tr>
      <td class="Label">Enter Password: (<em>hint:</em> Try "john")</td>
      <td><input type="password" size="10" name="User__Pass" value="<%=UserPass%>"></td>
  </tr>
  <tr>
      <td></td>
      <td><input Class="ActionButton" type="submit" value="Ok"></td>
  </tr>
</table>

</blockquote>

</form>

<%end if%>

</body>
</html>
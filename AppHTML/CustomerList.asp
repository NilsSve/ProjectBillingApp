<% '
   '  CustomerList
   '

   MaxRecs   = 10 ' maximum records per report
   ZoomURL   = "Customer.asp" ' name of zoom file. If blank none.
   RunReport = (Request("RunReport")<>"")

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>
<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>


<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If RunReport then '-------------run the report ------------- %>

<h3>Customer Listing</h3>

<%
    Index      = request("Index")           ' The last selected Index number
    StartRowId = request("Start")

    oCustomer.call "msg_SetHRefName", ZoomUrl

    EndRowId = oCustomer.call("get_RunCustomerReport", Index, StartRowId, MaxRecs)
%>

<% If StartRowId <>"" then %>
<A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>
<% end if %>

<% If EndRowId <>"" then %>
<A HREF="CustomerList.asp?RunReport=1&Start=<%=EndRowId%>&Index=<%=Index%>">Next Page</A>
<% end if %>

<br>
<A HREF="CustomerList.asp">New Report</A>

<% else  '-------------set up the report ------------- %>

<h3>Customer Listing</h3>

<form action="CustomerList.asp" method="GET">
<blockquote>

<table border="0">
  <tr>
    <td align="right"><strong>Report Order</strong></td>
    <td><% oCustomer.call "get_CreateFindIndexCombo", "Index", "Customer", Index %></td>
  </tr>
</table>

</blockquote>

<p>
<input type="submit" name="RunReport"   value="Run Report">
<input type="reset" value="Reset Form">
</p>
</form>

<% end if %>
</body>
</html>
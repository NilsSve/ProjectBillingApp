<% '
   '  Orders by Customer Report
   '

   MaxRecs    = 10 ' maximum records per report
   ZoomURL    = "OrderDtlreport.asp" ' name of zoom file. If blank none.
   RowId      = request("RowId") ' if non-zero, only run report for this Id
   StartRowId = request("Start") ' if running for all, where to start at

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Order Report</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>


<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<% If RowId <>"" then %>

  <h3>Orders by Customer Report</h3>

  <% oOrderReport.call "msg_SetHRefName", ZoomUrl %>
  <% EndRowId = oOrderReport.call("get_RunOrderReport", RowId) %>

  <A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>

<% else %>

  <h3>Orders by Customer Report</h3>

  <% oOrderReport.call "msg_SetHRefName", ZoomUrl %>
  <% EndRowId = oOrderReport.call("get_RunAllOrderReport", StartRowId, MaxRecs) %>

  <% If StartRowId <>"" then %>
    <A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>
  <% end if %>

  <% If EndRowId<>"" then %>
    <A HREF="OrderReport.asp?RowId=&Start=<%=EndRowId%>">Next Page</A>
  <% end if %>

<% end if %>

</body>
</html>
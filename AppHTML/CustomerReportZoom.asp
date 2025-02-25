<% '
   '  Customer Information Drill Down Report (Zoom)
   '

%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<title>Customer Report Zoom</title>

<% ' LoginRights:   If 1 user has full rights, if 0 or -1, browse only rights %>
<% LoginRights = request.cookies("Rights") %>

<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<h3>Customer Information Drill Down Report (Zoom)</h3>

<%
   RowID = Request("RowId")
   Err=oCustomerReport.RequestFindByRowId("Customer", RowId)
%>

<table border="0" width="99%" Class="ZoomTable">
  <tr>
    <th Class="Header" width="20%">Field Name</th>
    <th Class="Header">Value</th>
  </tr>
  <tr>
    <th Class="Label" width="20%">Customer Number</th>
    <td Class="Data"><%=FormatNumber(oCustomerReport.ddValue("Customer.Customer_Number"),0) %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Customer Name</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Name") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Active Status</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Status") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Street Address</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Address") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">City</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.City") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">State</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.State",DDDESC) %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Zip/Postal Code</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Zip") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Phone Number</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Phone_Number") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Fax Number</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Fax_Number") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">E-Mail Address</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Email_Address") %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Credit Limit</th>
    <td Class="Data"><%=FormatNumber(oCustomerReport.ddValue("Customer.Credit_Limit"),2) %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Total Purchases</th>
    <td Class="Data"><%=FormatNumber(oCustomerReport.ddValue("Customer.Purchases"),2) %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Balance Due</th>
    <td Class="Data"><%=FormatNumber(oCustomerReport.ddValue("Customer.Balance"),2) %></td>
  </tr>
  <tr>
    <th Class="Label" width="20%">Comments</th>
    <td Class="Data"><%=oCustomerReport.ddValue("Customer.Comments") %></td>
  </tr>
</table>

  <h4>All Orders for this Customer</h4>
  <% ZoomURL    = "OrderDtlreport.asp" ' name of zoom file. If blank none. %>
  <% oOrderReport.call "msg_SetHRefName", ZoomUrl %>
  <% EndRowId = oOrderReport.call("get_RunOrderReport", RowId) %>

  <A HREF="#" onClick="history.go(-1);return false;">Previous Page</A>
</form>

</body>
</html>



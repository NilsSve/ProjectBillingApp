<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>More about the Data Entry and Report Example</title>
<!-- The name of the style sheet is in Global.asa and stored in the session object -->
<LINK REL=STYLESHEET HREF="<%=Session("Style")%>" TYPE="text/css">
</head>

<body>

<h3>More about the Data Entry and Report Example</h3>

<p>More About HTML&nbsp;&nbsp;&nbsp; <a href="MoreWML.asp">More About WML</a>&nbsp;&nbsp;&nbsp;
<a href="MoreWebServices.asp">More About Web Services</a></p>

<h4>The HTML Samples</h4>

<p>You are encouraged to study the code for these samples. All of the files (WOs and ASP
pages) were created using the web application wizards. Once created, they were loaded intot the
studio and customized. Most of these customizations were quite simple. Some of the changes
you might want to checkout are: 

<ul>
  <li>All samples were created using Template.asp as the&lt;head&gt; template. This template
    contains all of the style information and provides the login logic used by each page.</li>
  <li>The samples use an external CSS file for all styles. The name of this CSS file is
    defined in Global.asa and stored in a session property. So, changing one line in
    Global.asa can give your application a completely new look.</li>
  <li>Logins are maintained by checking for a valid login name in a database. Once confirmed,
    the login name is stored as a cookie within the browser. As soon as the user, closes the
    browser, the cookie disappears.</li>
  <li>Reports and Entry capabilities are provided by the same WO. For example, Customer.asp
    and CustomerList.asp both use the same WO - oCustomer.</li>
  <li>Login logic determines if a user has save or delete rights. Notice that the login screen
    could be hidden from a user. Without the login screen a&nbsp; user would not ever realize
    that the additional save and delete capabilities even exist.</li>
  <li>All of the samples are using Runtime components (labels and input controls). This give
    you great flexibility. If you change the Data-Dictionaries and recompile your WOs, all
    pages will acquire the new change.</li>
  <li>Try running <a href="debug.asp">debug.asp</a>. This toggles a debug mode in the pages.
    When toggled to ON, these pages will all display the data that has been submitted by the
    browser. This is both a very useful debugging technique and a great way understand how
    data is submitted to the server.</li>
  <li>Study the samples in following order:<ul>
      <li>Customer and Sales Person - both provide basic data entry and reporting.</li>
      <li>Login - See how the login logic works. This provides a great example of creating a
        custom behavior in a WO. In this case, the only thing the login WO does is to check if a
        passed login value is valid. Once you understand how easy it is to create your own
        interfaces, you can do just about anything.</li>
      <li>Vendor - this supports an additional button that lets you run two types of reports - a
        vendor listing and an parts listing for the selected vendor.</li>
      <li>Inventory - This has a more complicated multi-file data entry set up, and this supports
        two types of reports.</li>
      <li>Customer Report - This is a drill down report. From customer we drill into a customer
        zoom (all created using the report wizard). We also create two child reports - one for
        Order Header and one for Order Detail (using the child report wizard). We then added a few
        lines of code to the customer zoom so that it calls the Order header child report after
        displaying the customer zoom data. The Order header report zooms into the order detail
        report. So, from customer we can zoom into detail, view all orders, and from any order
        view all detail.</li>
      <li>Order Report - We also added the Child Order report directly to the menu. When called
        from the menu, all orders are printed in customer groups. When called from the customer
        report, just the one customer's orders are shown.</li>
    </ul>
  </li>
</ul>

<h3>Some Additional Samples</h3>

<p>Here are a couple of other samples you should try running. Load these ASP files into
the studio and study the code:</p>

<p><a href="Customer0.asp">Customer0.asp</a></p>

<p>This shows many different examples of using the DDValue property in an ASP page. The
same type of control is created using multiple techniques. Study this code carefully.</p>

<p><a href="Customer1.asp">Customer1.asp</a></p>

<p>This uses the DDAUTO parameter in DDValue to create all of the controls. DDAUTO tells
the WO to create a the most appropriate control for a field based on the field's DD
characteristics. This is powerful.</p>

<p><a href="Customer2.asp">Customer2.asp</a></p>

<p>This sample lets you see how you can mix server side ASP script (VBScript) and WO
processing power. In this case, the controls are all built inside of a single VBScript
sub-routine. This subroutine makes the required calls to the WO.</p>

<p><a href="Customer3.asp">Customer3.asp</a></p>

<p>This sample will show you how to create a multi page data entry screen. The first page
asks for a couple of input items. When you click &quot;next&quot;, the partial data
will be submitted to the server (calling the same ASP file) and the data will be
validated. If valid, the next page is displayed. If not valid, the first page is
redisplayed with the errors properly marked.</p>

<p><a href="Vendor0.asp">Vendor0.asp</a></p>

<p>This shows you how you can quickly prototype a data entry screen and a report using the
AutoEntry and AutoReport capabilities of the WO. The entry screen is built using a single
WO function call that says &quot;build a data entry page for each field in the file using
the DDs to determine how the page should look. The report is built using a single WO
function that says &quot;Build a report for all fields in the file&quot;. Generally, this
type of automated entry is good for prototyping but not flexible enough for an actual
application. However, check out the results - they look pretty good.</p>
<p>More About HTML&nbsp;&nbsp;&nbsp; <a href="MoreWML.asp">More About WML</a>&nbsp;&nbsp;&nbsp;
<a href="MoreWebServices.asp">More About Web Services</a></p>

</body>
</html>
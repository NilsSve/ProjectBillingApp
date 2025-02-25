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

<p><a href="MoreHtml.asp">More About Html</a>&nbsp;&nbsp;&nbsp; More About WML&nbsp;&nbsp;&nbsp;
<a href="MoreWebServices.asp">More About Web Services</a></p>

<h4>The WAP / WML Samples</h4>
<p>In addition to providing standard HTML services to internet browsers, web
applications can be used with Wireless clients using WAP (Wireless Application Protocol).
WAP clients, the most common being cellular phones, use the WML as their markup
language. WML is a markup language similar to HTML. It was specifically created
to support wireless devices. WML is based on XML.</p>

<p>Order Entry contains a simple WML example that allows you to list customers
on your cell-phone, view customer data and to edit customer data (add, edit,
delete). If a WAP device accesses this sample&nbsp; (http://localhost/Order Entry),
it will recognize that this is a WAP client and redirect the page to the WAP samples. In addition a couple of sample
WML pages are provided to give you an
idea of how WML works.</p>

<h4>Getting Started</h4>

<p>Before you build WML pages you are going to need to learn more about WML and
the limitations of WAP devices&nbsp; There are numerous good sources for this.
We suggest you visit the phone.com web site (<a href="http://updev.phone.com">http://updev.phone.com</a>)
and download the SDK development
kit. The kit contains very good documentation on WAP in general and on the WML language in particular. It also contains a phone simulator. This allows you run
a WML phone simulator on your computer. Other phone simulators are available -
and you definitely want to have at least one. Downloading the SDK kit is free
although it does require registration.</p>

<p>The Opera browser (<a href="http://www.opera.com">http://www.opera.com</a>) also provides limited
WML support. This browser
can be downloaded for free and is worth using.</p>

<p>You cannot use the Microsoft IE browser to test your WML pages.</p>

<p>You will probably need to add WAP/WML mime types on you web server. The
following information must be added to your IIS web server.</p>

<blockquote>
text/vnd.wap.wml .wml<br>
image/vnd.wap.wbmp&nbsp; .wbmp<br>
application/vnd.wap.wmlc .wmlc<br>
text/vnd.wap.wmlscript .wmls<br>
application/vnd.wap.wmlscriptc .wmlsc</p>
</blockquote>

<p>
If you've got a phone simulator or the Opera Browser you can test if your web
server is properly supporting WML by accessing the test page Wml-Sample-1.wml
(e.g. http://localhost/Order Entry/Wml-Sample-1.wml). If this sample is not
working, your other samples will not work.</p>
<h4>Basic WML Examples</h4>

<p>We've provided several samples to give you an idea of what WML pages look
like. You are encouraged to review this source code and to try running these
inside your phone simulator. Most of these samples pages are static and are
therefore not the type of pages you will be using in a typical web application
where the WML pages will almost always be created dynamically. Also included are
two application samples, where the WML pages are generated dynamically.</p>

<p>The basic samples are:</p>

<p>Wml-Sample-1.wml</p>

<blockquote>
  <p>This is as simple as it gets. This creates a &quot;Hello World&quot; type
  of WML page.</p>

</blockquote>
<p>Wml-Sample-2.wml</p>

<blockquote>
  <p>     This sample was created to give you an idea of what a WML report might look like. This uses the
  WML <i>&lt;select></i> and <i> &lt;option></i> tags to create the report. You would rarely ever create a static page like this. Instead, you
  would use Visual DataFlex Web Application Server to generate a report like this dynamically (which is exactly what the
  WAP Report wizard     does and is what the WAPCustList sample does).</p>

</blockquote>
<p>Wml-Sample-3.wml</p>

<blockquote>
  <p>    This sample was created to give you an idea of what a WML Display form might look like.
  Normally a page like this would be generated dynamically&nbsp; (which is exactly what the
  WAP Entry wizard     does and is what the WAPCustList sample does).
  The results of that dynamic generation would look like this page.</p>

</blockquote>
<p>Wml-Sample-4.wml</p>

<blockquote>
  <p>    This sample was created to give you an idea of what a WML input form might look like. It uses
  the WMLl <i> &lt;input></i> tag to generate the input controls. Normally a
  page like this would be generated dynamically&nbsp; (which is exactly what the
  WAP Entry wizard     does and is what the WAPCustList sample does).
  The results of that dynamic generation would look like this page.</p>

</blockquote>
<p>Wml-Sample-5.asp</p>

<blockquote>
  <p>Unlike the other samples, this uses an ASP page which dynamically creates
  the WML page. This sample was created by loading the WML template sample. It contains the basics of
  needed to build a dynamic WML page.<br>
  </p>

</blockquote>
<h4>The WML Application Examples</h4>

<p>Below is a list of the WML components that are used as part of
WebAppSample10.
It might be worth nothing that these samples can be created, literally, in
minutes using the Visual DataFlex Web Application Server WAP generation wizards.</p>

<p>As you use a phone simulator (or a real wireless device) to test these
samples you will want to load the Visual DataFlex Studio, load the source files and study
these examples.</p>

<p>Default.asp and WAPDefault.asp</p>

<blockquote>
  <p>The Default.asp page,&nbsp; which is the default page accessed when this
  web site is requested contains code that checks to see if the requesting
  client is a WAP client. If it is, the page is redirected to WAPDefault.asp.
  This lets the same Web Site be used for different types of clients. WAPDefault.asp should contain the default display page for a
  WAP request. In
  this example, it redirects the request to WAPCustList.asp.</p>

  <p>The Default.asp page can be added, unchanged to any web application. The WAPDefault.asp page, which will get called for
  WAP requests, must be
  customized as required.</p>

</blockquote>
<p>WAPCustList.asp and WAPCustList.WO</p>

<blockquote>
  <p>This ASP page is requested when you wish to display a list of customers. It
  is used to initialize the report (select the index), seed the report
  (determine which record to start at) and to generate the report, which is
  accomplished by making a call to the oWAPCustList WO.&nbsp;</p>

  <p>This sample is generated entirely by Visual DataFlex Web Application
  Server's WAP Report generation wizard.
  These components are used in conjunction with the entry components, WAPCustomerMaint.asp and
  WAPCustomerMaint.WO.</p>

</blockquote>
<p>WAPCustomerMaint.asp and WAPCustomerMaint.WO</p>

<blockquote>
  <p>This ASP page is requested when you wish to display, edit or delete
  customer data. The ASP page contains the presentation logic and the oWAPCustomerMaint
  WO is used to handle all business logic (find records, save
  new records, edit records, find records, delete records).</p>

  <p>This sample is generated entirely by Visual DataFlex Web Application
  Server's WAP Entry generation wizard.
  These components are used in conjunction with the report components, WAPCustList.asp and
  WAPCustList.WO.</p>

  <p>Note that the WO, oWAPCustomerMaint is identical to the WO created
  by the Customer Entry HTML page (oCustomer). Had we wished, a single WO could be used to provide all
  services for both HTML and WML pages (after all this is business logic, which
  should be independent of display). We created two separate WOs to keep the
  samples clear.</p>

</blockquote>

  <p>Finally, note that this single sample application provides HTML, WML and XML
  services.</p>

<p><a href="MoreHtml.asp">More About Html</a>&nbsp;&nbsp;&nbsp; More About WML&nbsp;&nbsp;&nbsp;
<a href="MoreWebServices.asp">More About Web Services</a></p>

</body>
</html>




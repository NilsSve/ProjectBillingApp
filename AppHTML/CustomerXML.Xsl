<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">
<xsl:template match = "/">
<HTML>
<BODY>
<H1>Customer List</H1>
<TABLE BORDER = "1">
<TR>
<TD><B>Name</B></TD>
<TD><B>Number</B></TD>
<TD><B>State</B></TD>
</TR>
<xsl:for-each select="//Customer">
<TR>
<TD><xsl:value-of select="Name"/></TD>
<TD><xsl:value-of select="Number"/></TD>
<TD><xsl:value-of select="State"/></TD>
</TR>
</xsl:for-each>
</TABLE>
<H3>Hey, why is this a table?</H3>
This sample is displayed as a table because the XML document contains an XSL reference.
Look at the source and you will see <?xml-stylesheet type='text/xsl' href='customerxml.xsl'?>.
This loads the style sheet that the IE5 browser will use to display the XML data in an HTML table.
</BODY>
</HTML>
</xsl:template>
</xsl:stylesheet>








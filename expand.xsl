<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="cluster">
      <cluster>
	      <xsl:apply-templates/>
      </cluster>
    </xsl:template>

    <xsl:template match="title">
			<title>
				<xsl:apply-templates/>
			</title>
    </xsl:template>

    <xsl:template match="surnames-irish-main">
			<surnames-irish-main>
				<xsl:apply-templates/>
			</surnames-irish-main>
    </xsl:template>
    <xsl:template match="surnames-irish-historical">
			<surnames-irish-historical>
				<xsl:apply-templates/>
			</surnames-irish-historical>
    </xsl:template>
    <xsl:template match="surnames-irish-alternative">
			<surnames-irish-alternative>
				<xsl:apply-templates/>
			</surnames-irish-alternative>
    </xsl:template>

    <xsl:template match="surnames-english-main">
			<surnames-english-main>
				<xsl:apply-templates/>
			</surnames-english-main>
    </xsl:template>
    <xsl:template match="surnames-english-historical">
			<surnames-english-historical>
				<xsl:apply-templates/>
			</surnames-english-historical>
    </xsl:template>
    <xsl:template match="surnames-english-alternative">
			<surnames-english-alternative>
				<xsl:apply-templates/>
			</surnames-english-alternative>
    </xsl:template>

    <xsl:template match="surname-english">
      <xsl:variable name="form" select="form/text()"/>
			<surname-english>
				<form xml:space="preserve"><xsl:value-of select="$form"/></form>
			</surname-english>
    </xsl:template>

    <xsl:template match="surname-irish">
      <xsl:variable name="form" select="form/text()"/>
      <xsl:choose>
        <xsl:when test="starts-with($form, 'Ó ')"><xsl:call-template name="pattern-o"/></xsl:when>
        <xsl:when test="starts-with($form, 'Mac Giolla ')"><xsl:call-template name="pattern-mac-unmut"/></xsl:when>
        <xsl:when test="starts-with($form, 'Mac Con ')"><xsl:call-template name="pattern-mac-unmut"/></xsl:when>
        <xsl:when test="starts-with($form, 'Mac ')"><xsl:call-template name="pattern-mac"/></xsl:when>
        <xsl:when test="substring($form, string-length($form)-2)='ach' and not(contains($form, ' '))"><xsl:call-template name="pattern-adj-ach"/></xsl:when>
        <xsl:otherwise><xsl:call-template name="pattern-zero"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template name="pattern-zero">
      <xsl:variable name="form" select="form/text()"/>
      <surname-irish>
				<form xml:space="preserve" gender="male" case="nom"><xsl:copy-of select="$form"/></form>
				<form xml:space="preserve" gender="male" case="gen"><xsl:copy-of select="$form"/></form>
				<form xml:space="preserve" gender="male" case="voc"><xsl:copy-of select="$form"/></form>
				<form xml:space="preserve" gender="female" case="nom"><xsl:copy-of select="$form"/></form>
        <form xml:space="preserve" gender="female" case="gen"><xsl:copy-of select="$form"/></form>
				<form xml:space="preserve" gender="female" case="voc"><xsl:copy-of select="$form"/></form>
      </surname-irish>
    </xsl:template>

    <xsl:template name="pattern-o">
      <xsl:variable name="form" select="form/text()"/>
      <xsl:variable name="base"><xsl:call-template name="extract-base"><xsl:with-param name="what" select="$form"/></xsl:call-template></xsl:variable>
			<xsl:variable name="prefh"><xsl:call-template name="prefh"><xsl:with-param name="what" select="$base"/></xsl:call-template></xsl:variable>
      <xsl:variable name="lenited"><xsl:call-template name="lenite"><xsl:with-param name="what" select="$base"/></xsl:call-template></xsl:variable>
      <surname-irish>
				<form xml:space="preserve" gender="male" case="nom"><pre>Ó</pre> <xsl:copy-of select="$prefh"/></form>
				<form xml:space="preserve" gender="male" case="gen"><pre>Uí</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="male" case="voc"><pre>Uí</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="nom"><pre>Uí</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="gen"><pre>Uí</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="voc"><pre>Uí</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="nom"><pre>Ní</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="gen"><pre>Ní</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="voc"><pre>Ní</pre> <xsl:copy-of select="$lenited"/></form>
      </surname-irish>
    </xsl:template>

    <xsl:template name="pattern-mac-unmut">
      <xsl:variable name="form" select="form/text()"/>
      <xsl:variable name="base"><xsl:call-template name="extract-base"><xsl:with-param name="what" select="$form"/></xsl:call-template></xsl:variable>
			<surname-irish>
				<form xml:space="preserve" gender="male" case="nom"><pre>Mac</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="male" case="gen"><pre>Mhic</pre> <xsl:copy-of select="$base"/></form>
                <form xml:space="preserve" gender="male" case="voc"><pre>Mhic</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="nom"><pre>Mhic</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="gen"><pre>Mhic</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="voc"><pre>Mhic</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="nom"><pre>Nic</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="gen"><pre>Nic</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="voc"><pre>Nic</pre> <xsl:copy-of select="$base"/></form>
      </surname-irish>
    </xsl:template>

    <xsl:template name="pattern-mac">
      <xsl:variable name="form" select="form/text()"/>
      <xsl:variable name="base"><xsl:call-template name="extract-base"><xsl:with-param name="what" select="$form"/></xsl:call-template></xsl:variable>
      <xsl:variable name="lenited"><xsl:call-template name="lenite-except-cg"><xsl:with-param name="what" select="$base"/></xsl:call-template></xsl:variable>
      <surname-irish>
				<form xml:space="preserve" gender="male" case="nom"><pre>Mac</pre> <xsl:copy-of select="$base"/></form>
				<form xml:space="preserve" gender="male" case="gen"><pre>Mhic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="male" case="voc"><pre>Mhic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="nom"><pre>Mhic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="gen"><pre>Mhic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="wife" case="voc"><pre>Mhic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="nom"><pre>Nic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="gen"><pre>Nic</pre> <xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" familyStatus="daughter" case="voc"><pre>Nic</pre> <xsl:copy-of select="$lenited"/></form>
      </surname-irish>
    </xsl:template>

    <xsl:template name="pattern-adj-ach">
      <xsl:variable name="form" select="form/text()"/>
      <xsl:variable name="lenited"><xsl:call-template name="lenite"><xsl:with-param name="what" select="$form"/></xsl:call-template></xsl:variable>
      <xsl:variable name="gm"><xsl:call-template name="genitivise-ending-masc"><xsl:with-param name="what" select="$lenited"/></xsl:call-template></xsl:variable>
      <xsl:variable name="gf"><xsl:call-template name="genitivise-ending-fem"><xsl:with-param name="what" select="$lenited"/></xsl:call-template></xsl:variable>
      <surname-irish>
				<form xml:space="preserve" gender="male" case="nom"><xsl:copy-of select="$form"/></form>
				<form xml:space="preserve" gender="male" case="gen"><xsl:copy-of select="$gm"/></form>
				<form xml:space="preserve" gender="male" case="voc"><xsl:copy-of select="$gm"/></form>
				<form xml:space="preserve" gender="female" case="nom"><xsl:copy-of select="$lenited"/></form>
				<form xml:space="preserve" gender="female" case="gen"><xsl:copy-of select="$gf"/></form>
				<form xml:space="preserve" gender="female" case="voc"><xsl:copy-of select="$gf"/></form>
      </surname-irish>
    </xsl:template>


    <xsl:template name="extract-base">
      <xsl:param name="what"/>
      <xsl:choose>
        <xsl:when test="starts-with($what, 'Ó h')"><xsl:value-of select="substring($what, 4)"/></xsl:when>
        <xsl:when test="starts-with($what, 'Ó ')"><xsl:value-of select="substring($what, 3)"/></xsl:when>
        <xsl:when test="starts-with($what, 'Mac ')"><xsl:value-of select="substring($what, 5)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$what"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template name="prefh">
      <xsl:param name="what"/>
      <xsl:choose>
        <xsl:when test="contains('AÁEÉIÍOÓUÚ', substring($what, 1, 1))"><mut>h</mut><xsl:value-of select="$what"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$what"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

	<xsl:template name="lenite">
      <xsl:param name="what"/>
      <xsl:choose>
        <xsl:when test="starts-with($what, 'B') and not(starts-with($what, 'Bh'))">B<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'C') and not(starts-with($what, 'Ch'))">C<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'D') and not(starts-with($what, 'Dh'))">D<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'F') and not(starts-with($what, 'Fh'))">F<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'G') and not(starts-with($what, 'Gh'))">G<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'M') and not(starts-with($what, 'Mh'))">M<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'P') and not(starts-with($what, 'Ph'))">P<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'S') and contains('rnlaeiouáéíóú', substring($what, 2, 1))">S<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'T') and not(starts-with($what, 'Th'))">T<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$what"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template name="lenite-except-cg">
      <xsl:param name="what"/>
      <xsl:choose>
        <xsl:when test="starts-with($what, 'B') and not(starts-with($what, 'Bh'))">B<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'D') and not(starts-with($what, 'Dh'))">D<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'F') and not(starts-with($what, 'Fh'))">F<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'M') and not(starts-with($what, 'Mh'))">M<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'P') and not(starts-with($what, 'Ph'))">P<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'S') and contains('rnlaeiouáéíóú', substring($what, 2, 1))">S<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:when test="starts-with($what, 'T') and not(starts-with($what, 'Th'))">T<mut>h</mut><xsl:value-of select="substring($what, 2)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$what"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template name="genitivise-ending-masc">
      <xsl:param name="what"/>
      <xsl:choose>
        <xsl:when test="substring($what, string-length($what)-2)='ach'"><xsl:value-of select="substring($what, 1, string-length($what)-3)"/>aigh</xsl:when>
        <xsl:otherwise><xsl:value-of select="$what"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template name="genitivise-ending-fem">
      <xsl:param name="what"/>
      <xsl:choose>
        <xsl:when test="substring($what, string-length($what)-2)='ach'"><xsl:value-of select="substring($what, 1, string-length($what)-3)"/>aí</xsl:when>
        <xsl:otherwise><xsl:value-of select="$what"/></xsl:otherwise>
      </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
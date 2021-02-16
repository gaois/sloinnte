# Database of Irish-Language Surnames

This repository contains a snapshot of the Database of Irish-Language Surnames *(Bunachar Sloinnte Gaeilge)* developed by the Gaois research group in *Fiontar & Scoil na Gaeilge* in Dublin City University. The structure and design principles of the database are described in this publication:

> Brian Ó Raghallaigh, Michal Boleslav Měchura, Aengus Ó Fionnagáin, & Sophie Osborne. (2021). Developing the Gaois Linguistic Database of Irish-language Surnames. *Names*, *69*(1), 10–19. [https://doi.org/10.5195/names.2021.2251](https://doi.org/10.5195/names.2021.2251)

You can browse the database through our web interface at [www.gaois.ie/sloinnte/](https://www.gaois.ie/en/surnames/). This repository contains a downloadable version of the database in XML format which you can reuse in your own applications.

## `minimal.xml`

This file contains the database in *minimal* format. Example:

```xml
  <cluster>
    <title>Ceallach</title>
    <surnames-irish-main>
      <surname-irish>
        <form>Ó Ceallaigh</form>
      </surname-irish>
      <surname-irish>
        <form>Mac Ceallaigh</form>
      </surname-irish>
    </surnames-irish-main>
    <surnames-irish-historical />
    <surnames-irish-alternative />
    <surnames-english-main>
      <surname-english>
        <form>Kelly</form>
      </surname-english>
      <surname-english>
        <form>O'Kelly</form>
      </surname-english>
    </surnames-english-main>
    <surnames-english-historical />
    <surnames-english-alternative />
  </cluster>
```

Each `<cluster>` contains at least one `<surname-irish>` and at least one `<surname-english>`. Each `<surname-irish>` and each `<surname-english>` contains exactly one `<form>`. There are over 600 such clusters in the database (and in the XML file). Each cluster groups surnames in both languages (Irish and English) which are more or less equivalent (see the publication for an explanation of how we decide when surnames are equivalent and when not).

## `expand.xsl`

This XSL stylesheet can be used to transform the database from the *minimal* format into an *expanded* format. It contains an algorithm for detecting which **inflection pattern** an Irish-language surname belongs to, and for inflecting surnames according to such patterns.

## `expanded.xml`

This file contains the database in *expanded* format, after it has been transformed by the stylesheet. Example:

```xml
  <cluster>
    <title>Ceallach</title>
    <surnames-irish-main>
      <surname-irish>
        <form gender="male" case="nom"><pre>Ó</pre> Ceallaigh</form>
        <form gender="male" case="gen"><pre>Uí</pre> C<mut>h</mut>eallaigh</form>
        <form gender="male" case="voc"><pre>Uí</pre> C<mut>h</mut>eallaigh</form>
        <form gender="female" familyStatus="wife" case="nom"><pre>Uí</pre> C<mut>h</mut>eallaigh</form>
        <form gender="female" familyStatus="wife" case="gen"><pre>Uí</pre> C<mut>h</mut>eallaigh</form>
        <form gender="female" familyStatus="wife" case="voc"><pre>Uí</pre> C<mut>h</mut>eallaigh</form>
        <form gender="female" familyStatus="daughter" case="nom"><pre>Ní</pre> C<mut>h</mut>eallaigh</form>
        <form gender="female" familyStatus="daughter" case="gen"><pre>Ní</pre> C<mut>h</mut>eallaigh</form>
        <form gender="female" familyStatus="daughter" case="voc"><pre>Ní</pre> C<mut>h</mut>eallaigh</form>
      </surname-irish>
      <surname-irish>
        <form gender="male" case="nom"><pre>Mac</pre> Ceallaigh</form>
        <form gender="male" case="gen"><pre>Mhic</pre> Ceallaigh</form>
        <form gender="male" case="voc"><pre>Mhic</pre> Ceallaigh</form>
        <form gender="female" familyStatus="wife" case="nom"><pre>Mhic</pre> Ceallaigh</form>
        <form gender="female" familyStatus="wife" case="gen"><pre>Mhic</pre> Ceallaigh</form>
        <form gender="female" familyStatus="wife" case="voc"><pre>Mhic</pre> Ceallaigh</form>
        <form gender="female" familyStatus="daughter" case="nom"><pre>Nic</pre> Ceallaigh</form>
        <form gender="female" familyStatus="daughter" case="gen"><pre>Nic</pre> Ceallaigh</form>
        <form gender="female" familyStatus="daughter" case="voc"><pre>Nic</pre> Ceallaigh</form>
      </surname-irish>
    </surnames-irish-main>
    <surnames-irish-historical />
    <surnames-irish-alternative />
    <surnames-english-main>
      <surname-english>
        <form>Kelly</form>
      </surname-english>
      <surname-english>
        <form>O'Kelly</form>
      </surname-english>
    </surnames-english-main>
    <surnames-english-historical />
    <surnames-english-alternative />
  </cluster>
```

The *expanded* format has the same structure as the *minimal* format, except that each `<surname-irish>` contains a larger number of `<form>` elements.

- If the surname takes on different shapes for men and women (which most – but not all! – Irish-language surnames do), then those forms are distinguished with the  `gender` attribute (value `male` or `female`).

- If the woman's surname takes on different shapes depending on whether the bearer of the name is conceptualized as a "wife" or as a "daughter" (which most – but not all! – Irish-language female surnames do), then those forms are distinguished with the `familyStatus` attribute (value `wife` or `daughter`).

- Each Irish-language `<form>` also has a `case` attribute to tell you which grammatical case this form is in: nominative (`nom`), genitive (`gen`) or vocative (`voc`).

The text content of each Irish-language `<form>` is maked up with the following inline elements:

- `<pre>` marks up prefixed elements such as `Ó` and `Mac` as well their inflected forms.
- `<mut>` marks up initial mutations caused  by the prefixed elements.

If you remove the `<pre>` and `<mut>` elements (including their content) from the `<form>` and trim any leading whitespace from the result, you will end up with a gender-neutral, family status-neutral sortkey for the surname.


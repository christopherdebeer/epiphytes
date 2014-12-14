module.exports = RT023_ASSETS =
  nosuchstateasset:
    text: """
      ERROR! Status: 4. 0. 4.
      To return to the main menu, Press 9.
    """
    repeatDelay: 5000
    actions:
      "9": "start"
  start:
    text: """
	Welcome. In celebration of the wired dot co dot uk podcast's 200th episode. We are proud to bring you the following options.
	If you are a regular listener, please Press 1.
	If you'd like more infomation, Press 2.
	To leave a message, Press 5.
	If you are, infact an employee of conday nast, or wired dot co dot uk, please press 7.
	Press 9, to return to the main menu.
    """
    repeatDelay: 3000
    actions:
      "1": "regular"
      "2": "info"
      "5": "message"
      "7": "employee"
      "9": "start"

  regular:
    text: """
      Welcome listener, I'd always hoped that one day, our paths would cross.
      Press 1, to reminisce about the past.
      Press 2, ask the wired podcast hosts a question.
      Press 3, to contribute to the feedback loop. 
      Press 9, to return to the main menu.
    """
    repeatDelay: 3000
    actions:
     "1": "past"
     "2": "message"
     "3": "message"
     "9": "start"

  past:
    text: """
      Great! We all have our own memories of the Wired Podcast, tell us some of yours.
      To tell us about your favorite episode, Press 1.
      Press 2, to to tell us about your oldest memory of the podcast.
      Press 3, to tell us a story, that involves you...
      If you'd just like to say Hi, Press 5.
      Press 9, to return to the main menu.
    """
    repeatDelay: 3000
    actions:
      "1": "message"
      "2": "message"
      "3": "message"
      "5": "message"
      "9": "start"

  employee:
    text: """
      First, I would like to take this opportunity to thank you for the work you have done, and cannot express enough how much listening to Nate, Duncan, Liat, Katie and Olivia every week has been a pleasure and a privilege.

      What follows is a series of questions for you from a fan of the show.

      Please state your name for the record.


     Start recording your message by pressing 1. To submit your message press the hash key.
    """
    repeatDelay: 3000
    actions:
     "1": "#startRecordingAudio"
     "#": "#submitRecordedAudio"
     "9": "start"
     "next": "q2"
  q2:
    text: """
      Answer submitted.
      What was your favorite wired.co.uk podcast episode?

     Start recording your message by pressing 1. To submit your message press the hash key.
    """
    repeatDelay: 3000
    actions:
     "1": "#startRecordingAudio"
     "#": "#submitRecordedAudio"
     "9": "start"
     "next": "q3"
  q3:
    text: """
      Answer submitted.
      If you would make any predictions about the next 5 years in technology and media, what would it be?

     Start recording your message by pressing 1. To submit your message press the hash key.
    """
    repeatDelay: 3000
    actions:
     "1": "#startRecordingAudio"
     "#": "#submitRecordedAudio"
     "9": "start"
     "next": "leftmessage"

  info:
    text: """
      You requested more information. For more information about the web in general, Press 1.
      To find out more about Wired.co.uk, Press 2.
      If you would like information about this terminal, Please press 7.
      Press 9, to return to the main menu.
    """
    repeatDelay: 3000
    actions:
      "1": "techinfo"
      "2": "wiredinfo"
      "7": "appinfo"
      "9": "start"

  appinfo:
    text: """
      This application, or feedback loop interface terminal, was created by Christopher de Beer as a gift to the wired dot co dot uk podcast team. It was made in haste, but with much love and admiration for the show that has informed more than its fair share of citizens of the web. 

        The appplication was built, thanks to and using but not limited to the following: Docker, The new Web Audio API, vim, Backbone, and Node JS. Text To Speech API provided by: TTS hyphen API dot com.

      Press 9, to return to the main menu.


    """
    repeatDelay: 3000
    actions:
      "9": "start"

  wiredinfo:
    text: """
      What follows is the full wikipedia page transcript as of 28th of November 2014. Press 9, at any time to return to the main menu.
      Wired UK is a full-colour monthly magazine that reports primarily on the effects of science and technology. It covers a broad range of topics including design, architecture, culture, the economy, politics and philosophy. Owned by Conday Nast Publications, it is published in London and is an offshoot of the original American Wired.

Contents 
1 History
1.1 Current version (2009-present)
1.2 Earlier version (mid-1990s)
2 Wired Conference
3 References
4 External links
History
Current version (2009-present)
The current version of the magazine was launched in April 2009, and was the second international version of Wired, after the launch of Wired Italia in March 2009. In November 2009, the British Society of Magazine Editors awarded Launch of the Year to Wired editor David Rowan. Nate Lanxon (formerly of CNET UK) took over position of editor for Wired.co.uk in January 2010.

Earlier version (mid-1990s)

Cover of the April 1995 launch issue.
The magazine's current incarnation follows an earlier attempt at a British edition of Wired[2] which ran from April 1995[3] until March 1997.[4] It was initially created as a joint venture with the Guardian Media Group[5] and Wired US.'.s then owners, Wired Ventures, but that incarnation lasted only three[6] or four[7] issues, due to a culture clash between the two parties[2][5] and low sales figures of 25,000 per month.[6] Wired Ventures then ran the UK edition alone, with an almost entirely new staff,[8] until the magazine was closed with the March 1997 issue, when sales were at 40,000 magazines per month.[6]

Wired Conference
Wired UK, together with Telefonica, held a two-day event on 25-26 October 2012 at The Brewery in London. The conference was designed to "explore the ideas, innovations and people that are reshaping our world".[9] Among its speakers were David Karp, founder of microblogging platform Tumblr, and Mona Eltahawy, an Egyptian-American freelance journalist and commentator.

Wired 2011, hosted between 13-14 October at the St. Pancras Renaissance London Hotel, included guest speakers Joanna Shields, Managing Director and Vice President of Facebook EMEA, and Gil Hirsch, founder of Face.com.[10]
    """
    repeatDelay: 3000
    actions:
      "9": "start"

  message:
    text: """
      Start recording your message by pressing 1. To submit your message press the hash key.
    """
    repeatDelay: 3000
    actions:
     "1": "#startRecordingAudio"
     "#": "#submitRecordedAudio"
     "9": "start"
     "next": "leftmessage"

  leftmessage:
    text: """
      Your message has been successfuly submitted, Press 9, to return to the main menu.
    """
    repeatDelay: 3000
    actions:
      "9": "start"

  techinfo: 
    text: """
    What follows is the full wikipedia page transcript for the world wide web. as of 3rd December 2014. Press 9, at any time to return to the main menu.
The World Wide Web ("WWW" or simply the "Web") is a global information medium which users can read and write via computers connected to the Internet. The term is often mistakenly used as a synonym for the Internet itself, but the Web is a service that operates over the Internet, just as e-mail also does. The history of the Internet dates back significantly further than that of the World Wide Web.

Contents   
1 Precursors
2 1980–1991: Invention of the Web
3 1992–1995: Growth of the Web
3.1 Early browsers
3.2 Web governance
4 1996–1998: Commercialization of the Web
5 1999–2001: "Dot-com" boom and bust
6 2002–present: The Web becomes ubiquitous
6.1 Web 2.0
6.2 The semantic web
7 See also
8 References
9 External links

Precursors

The hypertext portion of the Web in particular has an intricate intellectual history; notable influences and precursors include Vannevar Bush's Memex, IBM's Generalized Markup Language, and Ted Nelson's Project Xanadu.

Paul Otlet's Mundaneum project has also been named as an early 20th century precursor of the Web.

The concept of a global information system connecting homes is prefigured in "A Logic Named Joe", a 1946 short story by Murray Leinster, in which computer terminals, called "logics," are present in every home. Although the computer system in the story is centralized, the story anticipates a ubiquitous information environment similar to the Web.

1980–1991: Invention of the Web

The NeXTcube used by Tim Berners-Lee at CERN became the first Web server.
In 1980, Tim Berners-Lee, an independent contractor at the European Organization for Nuclear Research (CERN), Switzerland, built ENQUIRE, as a personal database of people and software models, but also as a way to play with hypertext; each new page of information in ENQUIRE had to be linked to an existing page.

In 1984 Berners-Lee returned to CERN, and considered its problems of information management: physicists from around the world needed to share data, yet they lacked common machines and any shared presentation software.

Shortly after Berners-Lee's return to CERN, TCP/IP protocols were installed on some key non-Unix machines at the institution, turning it into the largest Internet site in Europe within a few years. As a result, CERN's infrastructure was ready for Berners-Lee to create the Web.

Berners-Lee wrote a proposal in March 1989 for "a large hypertext database with typed links". Although the proposal attracted little interest, Berners-Lee was encouraged by his boss, Mike Sendall, to begin implementing his system on a newly acquired NeXT workstation. He considered several names, including Information Mesh, The Information Mine or Mine of Information, but settled on World Wide Web.


Robert Cailliau, Jean-François Abramatic and Tim Berners-Lee at the 10th anniversary of the WWW Consortium.
Berners-Lee found an enthusiastic collaborator in Robert Cailliau, who rewrote the proposal (published on November 12, 1990) and sought resources within CERN. Berners-Lee and Cailliau pitched their ideas to the European Conference on Hypertext Technology in September 1990, but found no vendors who could appreciate their vision of marrying hypertext with the Internet.

By Christmas 1990, Berners-Lee had built all the tools necessary for a working Web: the HyperText Transfer Protocol (HTTP) 0.9, the HyperText Markup Language (HTML), the first Web browser (named WorldWideWeb, which was also a Web editor), the first HTTP server software (later known as CERN httpd), the first web server (http://info.cern.ch), and the first Web pages that described the project itself. The browser could access Usenet newsgroups and FTP files as well. However, it could run only on the NeXT; Nicola Pellow therefore created a simple text browser that could run on almost any computer called the Line Mode Browser. To encourage use within CERN, Bernd Pollermann put the CERN telephone directory on the web — previously users had to log onto the mainframe in order to look up phone numbers.

While inventing the Web, Berners-Lee spent most of his working hours in Building 31 at CERN (46.2325°N 6.0450°E), but also at his two homes, one in France, one in Switzerland. In January 1991 the first Web servers outside CERN itself were switched on.

The first web page may be lost, but Paul Jones of UNC-Chapel Hill in North Carolina revealed in May 2013 that he has a copy of a page sent to him in 1991 by Berners-Lee which is the oldest known web page. Jones stored the plain-text page, with hyperlinks, on a floppy disk and on his NeXT computer. CERN put the oldest known web page back online in 2014, complete with hyperlinks that helped users get started and helped them navigate what was then a very small web.

On August 6, 1991, Berners-Lee posted a short summary of the World Wide Web project on the alt.hypertext newsgroup, inviting collaborators. This date also marked the debut of the Web as a publicly available service on the Internet, although new users could only access it after August 23.

Paul Kunz from the Stanford Linear Accelerator Center visited CERN in September 1991, and was captivated by the Web. He brought the NeXT software back to SLAC, where librarian Louise Addis adapted it for the VM/CMS operating system on the IBM mainframe as a way to display SLAC’s catalog of online documents; this was the first web server outside of Europe and the first in North America. The www-talk mailing list was started in the same month.

An early CERN-related contribution to the Web was the parody band Les Horribles Cernettes, whose promotional image is believed to be among the Web's first five pictures.

1992–1995: Growth of the Web
In keeping with its birth at CERN, early adopters of the World Wide Web were primarily university-based scientific departments or physics laboratories such as Fermilab and SLAC. By January 1993 there were fifty Web servers across the world; by October 1993 there were over five hundred.

Early websites intermingled links for both the HTTP web protocol and the then-popular Gopher protocol, which provided access to content through hypertext menus presented as a file system rather than through HTML files. Early Web users would navigate either by bookmarking popular directory pages, such as Berners-Lee's first site at http://info.cern.ch/, or by consulting updated lists such as the NCSA "What's New" page. Some sites were also indexed by WAIS, enabling users to submit full-text searches similar to the capability later provided by search engines.

By the end of 1994, the total number of websites was still minute compared to present figures, but quite a number of notable websites were already active, many of which are the precursors or inspiring examples of today's most popular services.

Early browsers

The advent of the Mosaic browser in 1993 was a turning point in utility of the World Wide Web.
Initially, a web browser was available only for the NeXT operating system. This shortcoming was discussed in January 1992, and alleviated in April 1992 by the release of Erwise, an application developed at the Helsinki University of Technology, and in May by ViolaWWW, created by Pei-Yuan Wei, which included advanced features such as embedded graphics, scripting, and animation. ViolaWWW was originally an application for HyperCard. Both programs ran on the X Window System for Unix.

Students at the University of Kansas adapted an existing text-only hypertext browser, Lynx, to access the web. Lynx was available on Unix and DOS, and some web designers, unimpressed with glossy graphical websites, held that a website not accessible through Lynx wasn’t worth visiting.

The first Microsoft Windows browser was Cello, written by Thomas R. Bruce for the Legal Information Institute at Cornell Law School to provide legal information, since access to Windows was more widespread amongst lawyers than access to Unix. Cello was released in June 1993.

The Web was first popularized by Mosaic, a graphical browser launched in 1993 by Marc Andreessen's team at the National Center for Supercomputing Applications (NCSA) at the University of Illinois at Urbana-Champaign (UIUC). The origins of Mosaic date to 1992. In November 1992, the NCSA at the University of Illinois (UIUC) established a website. In December 1992, Andreessen and Eric Bina, students attending UIUC and working at the NCSA, began work on Mosaic with funding from the High-Performance Computing and Communications Initiative, a US-federal research and development program. Andreessen and Bina released a Unix version of the browser in February 1993; Mac and Windows versions followed in August 1993. The browser gained popularity due to its strong support of integrated multimedia, and the authors’ rapid response to user bug reports and recommendations for new features.

After graduation from UIUC, Andreessen and James H. Clark, former CEO of Silicon Graphics, met and formed Mosaic Communications Corporation to develop the Mosaic browser commercially. The company changed its name to Netscape in April 1994, and the browser was developed further as Netscape Navigator.

Web governance
In May 1994, the first International WWW Conference, organized by Robert Cailliau, was held at CERN; the conference has been held every year since. In April 1993, CERN had agreed that anyone could use the Web protocol and code royalty-free; this was in part a reaction to the perturbation caused by the University of Minnesota's announcement that it would begin charging license fees for its implementation of the Gopher protocol.

In September 1994, Berners-Lee founded the World Wide Web Consortium (W3C) at the Massachusetts Institute of Technology with support from the Defense Advanced Research Projects Agency (DARPA) and the European Commission. It comprised various companies that were willing to create standards and recommendations to improve the quality of the Web. Berners-Lee made the Web available freely, with no patent and no royalties due. The W3C decided that its standards must be based on royalty-free technology, so they can be easily adopted by anyone.

1996–1998: Commercialization of the Web
Main article: Web marketing
By 1996 it became obvious to most publicly traded companies that a public Web presence was no longer optional.[citation needed] Though at first people saw mainly[citation needed] the possibilities of free publishing and instant worldwide information, increasing familiarity with two-way communication over the "Web" led to the possibility of direct Web-based commerce (e-commerce) and instantaneous group communications worldwide. More dotcoms, displaying products on hypertext webpages, were added into the Web.

1999–2001: "Dot-com" boom and bust
Low interest rates in 1998–99 facilitated an increase in start-up companies. Although a number of these new entrepreneurs had realistic plans and administrative ability, most of them lacked these characteristics but were able to sell their ideas to investors because of the novelty of the dot-com concept.

Historically, the dot-com boom can be seen as similar to a number of other technology-inspired booms of the past including railroads in the 1840s, automobiles in the early 20th century, radio in the 1920s, television in the 1940s, transistor electronics in the 1950s, computer time-sharing in the 1960s, and home computers and biotechnology in the early 1980s.

In 2001 the bubble burst, and many dot-com startups went out of business after burning through their venture capital and failing to become profitable. Many others, however, did survive and thrive in the early 21st century. Many companies which began as online retailers blossomed and became highly profitable. More conventional retailers found online merchandising to be a profitable additional source of revenue. While some online entertainment and news outlets failed when their seed capital ran out, others persisted and eventually became economically self-sufficient. Traditional media outlets (newspaper publishers, broadcasters and cablecasters in particular) also found the Web to be a useful and profitable additional channel for content distribution, and an additional means to generate advertising revenue. The sites that survived and eventually prospered after the bubble burst had two things in common; a sound business plan, and a niche in the marketplace that was, if not unique, particularly well-defined and well-served.

2002–present: The Web becomes ubiquitous
In the aftermath of the dot-com bubble, telecommunications companies had a great deal of overcapacity as many Internet business clients went bust. That, plus ongoing investment in local cell infrastructure kept connectivity charges low, and helping to make high-speed Internet connectivity more affordable. During this time, a handful of companies found success developing business models that helped make the World Wide Web a more compelling experience. These include airline booking sites, Google's search engine and its profitable approach to keyword-based advertising, as well as eBay's auction site and Amazon.com's online department store.

This new era also begot social networking websites, such as MySpace and Facebook, which gained acceptance rapidly and became a central part of youth culture.

Web 2.0
Beginning in 2002, new ideas for sharing and exchanging content ad hoc, such as Weblogs and RSS, rapidly gained acceptance on the Web. This new model for information exchange, primarily featuring user-generated and user-edited websites, was dubbed Web 2.0. The Web 2.0 boom saw many new service-oriented startups catering to a newly democratized Web.

As the Web became easier to query, it attained a greater ease of use overall and gained a sense of organization which ushered in a period of rapid popularization. New sites such as Wikipedia and its sister projects are based on the concept of user edited content. In 2005, three former PayPal employees created a video viewing website called YouTube, which became popular quickly and introduced a new concept of user-submitted content in major events, as in the CNN-YouTube Presidential Debates.

The popularity of YouTube, Facebook, etc., combined with the increasing availability and affordability of high-speed connections has made video content far more common on all kinds of websites. Many video-content hosting and creation sites provide an easy means for their videos to be embedded on third party websites without payment or permission.

This combination of more user-created or edited content, and easy means of sharing content, such as via RSS widgets and video embedding, has led to many sites with a typical "Web 2.0" feel. They have articles with embedded video, user-submitted comments below the article, and RSS boxes to the side, listing some of the latest articles from other sites.

Continued extension of the Web has focused on connecting devices to the Internet, coined Intelligent Device Management. As Internet connectivity becomes ubiquitous, manufacturers have started to leverage the expanded computing power of their devices to enhance their usability and capability. Through Internet connectivity, manufacturers are now able to interact with the devices they have sold and shipped to their customers, and customers are able to interact with the manufacturer (and other providers) to access new content.

"Web 2.0" has found a place in the English lexicon.

The semantic web
Popularized by Berners-Lee's book Weaving the Web and a Scientific American article by Berners-Lee, James Hendler, and Ora Lassila, the term Semantic Web describes an evolution of the existing Web in which the network of hyperlinked human-readable web pages is extended by machine-readable metadata about documents and how they are related to each other, enabling automated agents to access the Web more intelligently and perform tasks on behalf of users. This has yet to happen. In 2006, Berners-Lee and colleagues stated that the idea "remains largely unrealized".
    """
    repeatDelay: 3000
    actions:
      "9": "start"
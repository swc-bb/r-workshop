<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/reveal.js/3.0.0/css/reveal.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/reveal.js/3.0.0/css/theme/white.css">
		<!-- Code syntax highlighting -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/reveal.js/3.0.0/lib/css/zenburn.css">
	</head>
	<body>
		<div class="reveal">
          <div class="slides">
          </section>
           <!-- separator -->
            <section>
               <h2><i> R </i></h2>
               <p>
               </p>
               <h3>on the GFZ High Performance Cluster </h3>
               <p>
               </p>
                <h5> ~5 slides for ~3400 cores </h5>
              </section>
<section data-markdown>
<textarea data-template>
## Page title
</textarea>
</section>
		</div>
		</div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/headjs/1.0.3/head.min.js"></script>
		<script src="https://cdn.jsdelivr.net/reveal.js/3.0.0/js/reveal.js"></script>
        <script>
          Reveal.initialize( 
    {
    // Display controls in the bottom right corner
	controls: true,
	// Display a presentation progress bar
	progress: true,
	// Display the page number of the current slide
	slideNumber: true,
	// Push each slide change to the browser history
	history: false,
	// Enable keyboard shortcuts for navigation
	keyboard: true,
	// Enable the slide overview mode
	overview: true,
	// Vertical centering of slides
	center: true,
	// Turns fragments on and off globally
	fragments: true,
	// Flags if the presentation is running in an embedded mode,
	// i.e. contained within a limited portion of the screen
	embedded: false,
	// Flags if we should show a help overlay when the questionmark
	// key is pressed
	help: true,
	// Hides the address bar on mobile devices
	hideAddressBar: true,
	// Transition style
	transition: 'slide', // none/fade/slide/convex/concave/zoom
	// Transition speed
    transitionSpeed: 'default', // default/fast/slow
    dependencies: [
		// Cross-browser shim that fully implements classList - https://github.com/eligrey/classList.js/
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/lib/js/classList.js', condition: function() { return !document.body.classList; } },

		// Interpret Markdown in <section> elements
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },

		// // Syntax highlight for <code> elements
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
        //
		// // Zoom in and out with Alt+click
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/plugin/zoom-js/zoom.js', async: true },
        //
		// // Speaker notes
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/plugin/notes/notes.js', async: true },
        //
		// // MathJax
		{ src: '//cdn.jsdelivr.net/reveal.js/3.0.0/plugin/math/math.js', async: true }
	]
    });
		</script>
	</body>
  </html>

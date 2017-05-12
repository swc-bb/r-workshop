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
           <!-- separator -->
           <section>
             <h4>Implementation </h4>
             <p>
             <ul>
               <li>MPI with the openmpi library/module</li>
               <li>GCC  library/module</li>
             </ul>
             <p>
             <pre><code class="bash" contenteditable>
                  module purge
                  module load R/R-3.2
             </code></pre>
             </p>
             <h4>R packages </h4>
             <ul>
               <li>foreach</li>
               <li>doMPI</li>
             </ul>
             </p>
           </section>
           <!-- separator -->
           <section>
             <h4>Minimal example</h4>
             <p> Lets create a file par_mpi.R </p>
             <pre><code contenteditable>
              # load required libraries
              library(foreach)
              library(doMPI)

              # prepare the parallelization
              cl = startMPIcluster()
              registerDoMPI(cl)

              # run a loop over X iterations
              output = foreach(i = vector_X) %dopar% {
                ...
                ...
              }

              # unregister the cluster for R
              closeCluster(cl)

              # save the output
              save.image()
             </code></pre>
           </section>
           <section>
             <h4>Minimal example</h4>
             <p> How to run that script? </p>
             <pre><code class="bash" contenteditable>
              bsub -a openmpi \
                   -n 400 \
                   -o par_mpi.out \
                   mpirun.lsf Rscript par_mpi.R
             </code></pre>
           </section>
           </section>
           <section>
             <h4>Scaling challenges</h4>
                    <img width="900" data-src="./pictures/time.png" alt="sketch" style="background:none; border:none">
           </section>
           <section>
             <h4>Scaling challenges</h4>
                    <img width="900" data-src="./pictures/perf.png" alt="sketch" style="background:none; border:none">
           </section>
           <section>
             <h4>Potential pitfalls</h4>
             <ul>
               <li>no load balancing with the foreach package</li>
               <li>memory hungry (n-times number of cores)</li>
               <li>identification of blocks to parallelize</li>
               <li>debugging is hard</li>
             </ul>
           </section>
           <section>
             <h4>past applications</h4>
             <ul>
               <li>bootstrapping 
               <li>spatio-temporal analysis</li>
                   <ul>
                     <li>processing daily climate data (40 years) for the entire globe</li>
                     <li>processing climate data for multiple climate change scenarios</li>
                     <li>calibration of hydrological models</li>
                   </ul>
             </ul>
           </section>
           <section>
             <h4>Future work</h4>
             <p>
             <ul>
               <li>proper benchmark </li>
               <li>getting clear picture about load balancing </li>
               <li>extend the documentation for <a href="https://cran.r-project.org/web/packages/Rmpi/index.html">Rmpi</a></li>
               <li>explore other R-packages</li>
             </ul>
             </p>
             <h4>Documentation</h4>
             <p>
               <a href="http://dokuwiki.gfz-potsdam.de/datawiki/doku.php?id=hpc-cluster:r">GFZ DokuWiki</a>
             </p>
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

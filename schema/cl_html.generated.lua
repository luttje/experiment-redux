-- ! WARNING: THIS FILE IS AUTOMATICALLY GENERATED
-- ! DO NOT EDIT IT, YOUR CHANGES WILL BE OVERRIDDEN
return {
   ["terms-of-service.html"] = [[
      <!DOCTYPE html>
      <html lang="en">

      <head>
          <meta charset="UTF-8">
          <meta name="viewport"
                content="width=device-width, initial-scale=1.0">
          <title>Terms of Service</title>

          <!--
              Reminder to self: Garry's Mod's HTML is based on Awesomium, which is based on Chromium 18.
              This means that some modern features are not supported. So no fancy ES6 features like let,
              const, etc. And no CSS features like flexbox, grid, etc.
          -->

          <style>
              @font-face {
                  font-family: "LightsOut";
                  src: url(http://fastdl.experiment.games/resource/fonts/lightout.woff)
              }

              * {
                  box-sizing: border-box;
              }

              html, body {
                  margin: 0;
                  padding: 0;
                  width: 100%;
                  height: 100%;
              }

              body {
                  background: black;
                  color: white;
                  padding: 1em;
                  font-size: 16px;
                  font-family: Verdana, Geneva, Tahoma, sans-serif;
              }

              h1,
              h2,
              h3,
              h4,
              h5,
              h6 {
                  color: #A33426;
                  font-family: "LightsOut";
                  margin: 0;
              }

              h2 {
                  font-size: 1.8em;
                  font-weight: 900;
                  position: relative;
                  z-index: 1;
              }

              .wrapper {
                  max-width: 512px;
                  margin: 0 auto;
              }

              .logo {
                  max-width: 256px;
              }

              img {
                  position: relative;
                  width: 100%;
                  padding: 0;
                  margin: 0;
              }

              p {
                  margin: 0.5em;
                  line-height: 1.5em;
              }

              ul {
                  list-style-type: none;
                  margin: 0.25em 0 0 0;
                  padding: 0;
                  position: relative;
                  z-index: 1;
              }

              ul li::before {
                  content: "•";
                  color: #A33426;
                  display: inline-block;
                  margin: 0.5em;
              }

              .hidden {
                  display: none;
              }

              .my {
                  margin-top: 2em;
                  margin-bottom: 2em;
              }
              .mt-s {
                  margin-top: 1em;
              }

              a, .highlight {
                  color: #A33426;
              }

              button {
                  background: #A33426;
                  color: white;
                  border: none;
                  font-size: 1em;
                  padding: .5em 1em;
                  margin: 0.5em 0;
                  cursor: pointer;
                  font-family: Verdana, Geneva, Tahoma, sans-serif;
                  width: 100%;
              }

              button.huge {
                  font-size: 2em;
                  padding: .8em 1em;
              }

              button.gray {
                  background: #333;
              }

              input {
                  width: 100%;
                  padding: .5em;
                  margin: 0.5em 0;
                  font-size: 1em;
              }
          </style>
      </head>

      <body>
          <div class="wrapper logo">
              <img src="asset://garrysmod/materials/experiment-redux/logo.png">
          </div>
          <div class="wrapper my">
              <h2>WELCOME TO OUR SERVER!</h2>
              <p>
                  Thanks for considering to come play on our server! We're excited to have you join us.
              </p>
              <p>
                  Before we start playing we want to be transparent with you about
                  our <span class="highlight">data practices and policies</span>
                  and our <span class="highlight">terms of service</span>.
              </p>
          </div>
          <div class="wrapper my">
              <h2>YOUR DATA & RIGHTS</h2>
              <ul>
                  <li>
                      We collect and store your <span class="highlight">SteamID</span> and <span class="highlight">IP Address (last used to connect)</span> in our database.
                  </li>
                  <li>
                      We collect this in order to moderate our servers and provide a safe and enjoyable experience for all players.
                  </li>
                  <li>
                      We store this data for as long as our servers are operational.
                  </li>
              </ul>
              <p class="mt-s">
                  To request a copy of the data we have on you, or to file a complaint, do not hesitate to contact us at <span class="highlight">{{privacy_email}}</span>
              </p>
              <p class="mt-s">
                  To have your data removed from our database, click the "disagree"-button below or type <span class="highlight">/TermsOfService</span> in the chat.
              </p>
          </div>
          <div class="wrapper my">
              <h2>TERMS OF SERVICE</h2>
              <p>
                  By playing on our servers, you agree to the following terms:
              </p>
              <ul>
                  <li>
                      You will not use cheats, hacks, or any other third-party software that gives you an unfair advantage.
                  </li>
                  <li>
                      You will not exploit bugs or glitches, nor will you share them with others
                      (except through our GitHub repository: <a href="#" onclick="console.log('OPEN_URL:{{github_url}}')">{{github_url}}</a>)
                  </li>
                  <li>
                      You will not harass, bully, or discriminate against other players or their characters.
                  </li>
                  <li>
                      You will not spam, flood, or otherwise disrupt the chat.
                  </li>
                  <li>
                      You will not impersonate staff or other players.
                  </li>
              </ul>
          </div>
          <div class="wrapper my">
              <h2>CLOSED ALPHA TEST</h2>
              <p>
                  Our server is currently in a closed alpha test. This means:
              </p>
              <ul>
                  <li>
                      You may encounter bugs, glitches, and other issues.
                  </li>
                  <li>
                      Please help us by reporting these issues on our GitHub repository:
                      <a href="#" onclick="console.log('OPEN_URL:{{github_url}}')">{{github_url}}</a>
                  </li>
                  <li>
                      Your progress can be reset at any time.
                  </li>
              </ul>
          </div>
          <div class="wrapper my">
              <h2>AGREEMENT</h2>
              <p>
                  By clicking the "agree"-button below, you agree to the above terms and our data practices.
              </p>
              <button id="agreeButton" class="huge" onclick="console.log('TERMS_AGREED')">
                  I agree
              </button>
              <button id="disagreeButton" class="gray" onclick="disagree()">
                  I disagree
              </button>
              <div id="disagree-warning" class="hidden">
                  <p>
                      <strong>Beware:</strong> If you disagree to the terms, you will be disconnected from the server and your data will be removed from our database.
                      <span class="highlight">This action is irreversible. You will lose all progress and items you have gained on our servers.</span>
                  </p>
                  <p>
                      To confirm that you want to proceed, enter "delete everything" in the box below and click the button.
                  </p>
                  <input type="text" id="disagreeInput" placeholder="Enter 'delete everything'">
                  <button id="disagreeFinalize" class="gray" onclick="disagreeFinish()">
                      I disagree to the terms and want my data removed
                  </button>
              </div>
          </div>

          <script>
              function disagree() {
                  document.getElementById('disagree-warning').classList.remove('hidden');
                  window.scrollTo(0, document.body.scrollHeight);
              }

              function disagreeFinish() {
                  var input = document.getElementById('disagreeInput').value;

                  if (input === 'delete everything') {
                      console.log('TERMS_DISAGREED');
                  } else {
                      alert('Please enter "delete everything" to confirm');
                  }
              }
          </script>

          <script>
              // Garry's Mod's HTML panel doesn't support Array.from, so the following code only loads in the browser
              // we do this so we can test HTML in the browser without having to load Garry's Mod. Then in Garry's Mod we can
              // use the exact same HTML and this code will happily be ignored.
              if (Array.from) {
                  document.addEventListener('DOMContentLoaded', function (event) {
                      var newPath = "../content/";

                      document.querySelectorAll('img').forEach(function (img) {
                          if (img.src.includes('asset://garrysmod/')) {
                              img.src = img.src.replace('asset://garrysmod/', newPath);
                          }
                      });

                      document.querySelectorAll('style').forEach(function (style) {
                          var cssText = style.innerHTML;
                          var assetRegex = /asset:\/\/garrysmod\/(\S+)/g;

                          cssText = cssText.replace(assetRegex, function (match, path) {
                              return newPath + path;
                          });

                          style.innerHTML = cssText;
                      });
                  });
              }
          </script>
      </body>

      </html>
   ]],
   ["tutorial.html"] = [[
      <!DOCTYPE html>
      <html lang="en">

      <head>
          <meta charset="UTF-8">
          <meta name="viewport"
                content="width=device-width, initial-scale=1.0">
          <title>Tutorial</title>

          <!--
              Reminder to self: Garry's Mod's HTML is based on Awesomium, which is based on Chromium 18.
              This means that some modern features are not supported. So no fancy ES6 features like let,
              const, etc. And no CSS features like flexbox, grid, etc.
          -->

          <style>
              @font-face {
                  font-family: "LightsOut";
                  src: url(http://fastdl.experiment.games/resource/fonts/lightout.woff)
              }

              * {
                  box-sizing: border-box;
              }

              html, body {
                  margin: 0;
                  padding: 0;
                  width: 100%;
                  height: 100%;
              }

              body {
                  background: black;
                  color: white;
                  font-family: "LightsOut";
                  font-size: 32px;
                  padding: 1em;
              }

              h1,
              h2,
              h3,
              h4,
              h5,
              h6 {
                  margin: 0;
              }

              h2 {
                  color: #A33426;
                  font-size: 2em;
                  font-weight: 900;
                  position: relative;
                  z-index: 1;
              }

              .section {
                  position: relative;
                  min-height: 80%;
                  margin-top: 2em;
              }

              img {
                  position: relative;
                  width: 100%;
                  padding: 0;
                  margin: 0;
              }

              ul {
                  list-style-type: none;
                  margin: 1em 0 0 0;
                  padding: 0;
                  position: relative;
                  z-index: 1;
              }

              ul li::before {
                  content: "•";
                  color: #A33426;
                  display: inline-block;
                  margin: 0.5em;
              }

              .frame {
                  position: absolute;
                  display: inline-block;
                  max-width: 512px;
                  max-height: 512px;
                  width: 50%;
                  z-index: 0;
              }
              .frame::after {
                  position: absolute;
                  content: "";
                  top: 0;
                  left: 0;
                  right: 0;
                  bottom: 0;
                  background-image: url(asset://garrysmod/materials/experiment-redux/illustrations/vignette.png);
                  background-size: 100% 100%;
              }

              .aside {
                  padding: 2em;
                  position: absolute;
                  z-index: 1;
                  height: 100%;
              }

              .aside::before {
                  position: absolute;
                  content: "";
                  top: 0;
                  right: 0;
                  bottom: 0;
                  left: 0;
                  background-image: url(asset://garrysmod/materials/experiment-redux/illustrations/gradient.png);
                  background-size: 100% 100%;
                  background-repeat: repeat-y;
              }

              .left .frame {
                  left: 1em;
              }
              .left h2 {
                  text-align: right;
              }
              .left ul {
                  text-indent: 2em;
              }
              .left .aside {
                  right: 0;
              }
              .left .aside::before {
                  transform: scaleX(-1);
                  -webkit-transform: scaleX(-1);
              }

              .right .frame {
                  right: 1em;
              }
              .right h2 {
                  text-align: left;
              }
              .right ul {
                  text-align: left;
              }

              .button {
                  position: fixed;
                  width: 64px;
                  height: 64px;
                  z-index: 1;
                  cursor: pointer;
              }

              .button.center {
                  left: 50%;
                  transform: translateX(-50%);
                  -webkit-transform: translateX(-50%);
              }
              .button.top {
                  top: 1em;
              }
              .button.right {
                  right: 1em;
              }
              .button.bottom {
                  bottom: 1em;
              }
              .button.left {
                  left: 1em;
              }

              .button img {
                  filter: drop-shadow(0 0 0.2em #A33426);
                  -webkit-filter: drop-shadow(0 0 0.2em #A33426);
              }

              .hidden {
                  display: none;
              }
          </style>
      </head>

      <body>
          <div class="section left">
              <div class="frame"><img src="asset://garrysmod/materials/experiment-redux/illustrations/scavenging.png"></div>
              <div class="aside">
                  <h2>THROUGH ECHOES OF RUIN,<br>SCRAP TO SURVIVE</h2>
                  <ul>
                      <li>Scavenge the city for useful items.</li>
                      <li>You'll also find scrap and other materials.</li>
                      <li>Beware of hostile entities.</li>
                  </ul>
              </div>
          </div>
          <div class="section right">
              <div class="frame"><img src="asset://garrysmod/materials/experiment-redux/illustrations/generator.png"></div>
              <div class="aside">
                  <h2>WITH PATIENCE AND TIME,<br>STRENGTH WILL GROW</h2>
                  <ul>
                      <li>Bolt Generators will produce Bolts over time.</li>
                      <li>Scrap will power your Bolt Generator.</li>
                      <li>Bolts are used to purchase stronger equipment.</li>
                  </ul>
              </div>
          </div>
          <div class="section left">
              <div class="frame"><img src="asset://garrysmod/materials/experiment-redux/illustrations/apartment.png"></div>
              <div class="aside">
                  <h2>A FORTRESS OF SOLACE<BR>AMIDST DESPAIR</h2>
                  <ul>
                      <li>Rent an apartment to house your Bolt Generator.</li>
                      <li>You can lock your door as a first line of defense.</li>
                  </ul>
              </div>
          </div>
          <div class="section right">
              <div class="frame"><img src="asset://garrysmod/materials/experiment-redux/illustrations/raiding.png"></div>
              <div class="aside">
                  <h2>THE VIGILANT EVADE<BR>THE SHADOWS’ THROWS</h2>
                  <ul>
                      <li>Doors can be broken down by hostile entities.</li>
                      <li>Defend your apartment from raiders.</li>
                  </ul>
              </div>
          </div>
          <div class="section left">
              <div class="frame"><img src="asset://garrysmod/materials/experiment-redux/illustrations/the-business.png"></div>
              <div class="aside">
                  <h2>WITH BOLTS IN HAND,<BR>POWER WILL BE YOURS</h2>
                  <ul>
                      <li>Visit The Business to purchase powerful equipment.</li>
                      <li>Weapons, armor, and other items are available.</li>
                      <li>Be wary of the price of power.</li>
                  </ul>
              </div>
          </div>
          <div class="section right">
              <div class="frame"><img src="asset://garrysmod/materials/experiment-redux/illustrations/death.png"></div>
              <div class="aside">
                  <h2>IN DEATH, A NEW BEGINNING</h2>
                  <ul>
                      <li>When you die, you risk losing your items.</li>
                      <li>Use your experience to survive longer.</li>
                  </ul>
              </div>
          </div>
          <a class="button bottom center" id="nextButton" href="javascript:nextSection()">
              <img src="asset://garrysmod/materials/experiment-redux/arrow-down.png">
          </a>
          <a class="button top right" id="closeButton" href="javascript:close()">
              <img src="asset://garrysmod/materials/experiment-redux/close.png">
          </a>

          <script>
              var requestAnimationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame || window.mozRequestAnimationFrame;
              var autoScrolling = false;

              function smoothScrollTo(element, onFinished) {
                  var targetPosition = element.getBoundingClientRect().top;
                  var startPosition = window.pageYOffset;
                  var distance = targetPosition;
                  var duration = 800;
                  var startTime = null;

                  autoScrolling = true;

                  function animation(currentTime) {
                      if (startTime === null) {
                          startTime = currentTime;
                      }
                      var timeElapsed = currentTime - startTime;
                      var run = easeInOutQuad(timeElapsed, startPosition, distance, duration);

                      window.scrollTo(0, run);

                      if (timeElapsed < duration) {
                          requestAnimationFrame(animation);
                      } else {
                          startTime = null;
                          autoScrolling = false;

                          if (onFinished) {
                              onFinished();
                          }
                      }
                  }

                  function easeInOutQuad(t, b, c, d) {
                      t /= d / 2;
                      if (t < 1) return c / 2 * t * t + b;
                      t--;
                      return -c / 2 * (t * (t - 2) - 1) + b;
                  }

                  requestAnimationFrame(animation);
              }
          </script>

          <script>
              var sections = document.querySelectorAll('.section');
              var currentSection = 0;

              function close() {
                  console.log('CLOSE_READABLE');
              }

              function setButtonHidden(id, hidden) {
                  if (hidden) {
                      document.getElementById(id).classList.add('hidden');
                  } else {
                      document.getElementById(id).classList.remove('hidden');
                  }
              }

              function nextSection() {
                  currentSection++;

                  if (currentSection < sections.length) {
                      // sections[++currentSection].scrollIntoView({ behavior: 'smooth' });
                      setButtonHidden('nextButton', true);
                      smoothScrollTo(sections[currentSection], function () {
                          if (currentSection < sections.length - 1) {
                              setButtonHidden('nextButton', false);
                          }
                      });
                  }
              }

              document.addEventListener('scroll', function (event) {
                  if (autoScrolling) {
                      return;
                  }

                  var scrollY = window.scrollY + 5;
                  var windowHeight = window.innerHeight;

                  for (var i = 0; i < sections.length; i++) {
                      var section = sections[i];
                      var sectionTop = section.offsetTop;
                      var sectionHeight = section.offsetHeight;

                      if (scrollY >= sectionTop && scrollY < sectionTop + sectionHeight) {
                          currentSection = i;
                          break;
                      }
                  }

                  if (currentSection < sections.length - 1) {
                      setButtonHidden('nextButton', false);
                  }
              });

              document.addEventListener('keyup', function (event) {
                  if (event.keyCode === 27) {
                      close();
                  }
              });
          </script>

          <script>
              // Garry's Mod's HTML panel doesn't support Array.from, so the following code only loads in the browser
              // we do this so we can test HTML in the browser without having to load Garry's Mod. Then in Garry's Mod we can
              // use the exact same HTML and this code will happily be ignored.
              if (Array.from) {
                  document.addEventListener('DOMContentLoaded', function (event) {
                      var newPath = "../content/";

                      document.querySelectorAll('img').forEach(function (img) {
                          if (img.src.includes('asset://garrysmod/')) {
                              img.src = img.src.replace('asset://garrysmod/', newPath);
                          }
                      });

                      document.querySelectorAll('style').forEach(function (style) {
                          var cssText = style.innerHTML;
                          var assetRegex = /asset:\/\/garrysmod\/(\S+)/g;

                          cssText = cssText.replace(assetRegex, function (match, path) {
                              return newPath + path;
                          });

                          style.innerHTML = cssText;
                      });
                  });
              }
          </script>
      </body>

      </html>
   ]],
}

(function() {
   var app = {
     init: () => {
   
      document.addEventListener("DOMContentLoaded", () => {
         // setup tabs and hash pairs
        app.setupTabHashHandler();
           // loading screen
        const loadingEl = '.NT-loading';
        document.querySelector(loadingEl).classList.add('fadeOut');
        setTimeout(() => {
          document.querySelector(loadingEl).style.display = 'none';
        }, 1000);
      });

       // load services
      app.loadServices();
     },
     setTab: (hash) => {
      window.location.hash = hash;
     },
     setupTabHashHandler: () => {
        // hash handler for tabs
        document.querySelectorAll('.nav-tabs a').forEach((el) => {
          el.addEventListener('click', (e) => {
            app.setTab(el.hash);
          });
        });  

        if (window.location.hash) {
          hash = window.location.hash;
          let tab = document.querySelector('#nav-' + window.location.hash.slice(1) + '-tab');
          if (tab) {
            tab.click();
          } else {
            app.setTab('#reviews');
          }
        }
     
     },
     loadServices: () => {
      // if properly namespaced the DOM insertion is automated!
      Object.keys(window.NT).forEach((serviceKey) => {
        // now get service object
        Object.keys(window.NT[serviceKey]).forEach((widgetKey) => {
          try {
            const dom_id = `9Trails.${serviceKey}.${widgetKey}`;
            const currentWidget = window.NT[serviceKey][widgetKey];
            ReactDOM.render(React.createElement(currentWidget), document.getElementById(dom_id));
            // success
            console.log(`✅ ${serviceKey}.${widgetKey}`);
          } catch (e) {
            // error 
            console.log(`❌ ${serviceKey}.${widgetKey} --> An error occurred: ${e}`);
            // output
            console.error( `Error for ${serviceKey}.${widgetKey}`, e);
          }
        });
      });
     }
   };
  //  do the thing
   app.init();

  })();

const Pager = (() => {
  /*
  ##################################################################
  get container holding images urls as child elements
  get container for osd viewer
  get container wrapper of osd viewer
  ##################################################################
  */
  // var container = document.getElementById("container_facs_2");
  // container.style.display = "none";
  var height = screen.height;
  var container = document.getElementById("container_facs_1");
  var wrapper = document.getElementsByClassName("facsimiles")[0];

  const reader = document.getElementById("reader")

  /*
  ##################################################################
  check if osd viewer is visible or not
  if true get width from sibling container
  if false get with from sibling container divided by half
  height is always the screen height minus some offset
  ##################################################################
  */
  if (!wrapper.classList.contains("fade")) {
    container.style.height = `${String(height / 1)}px`;
    var textContainer = document.getElementById("section");
    if (textContainer) {
      textContainer.style.height = container.style.height;
    }
    // set osd wrapper container width
    var container = document.getElementById("section");
    if (container !== null) {
      var width = container.clientWidth;
    }
    var container = document.getElementById("viewer");
    //container.style.width = `${String(width - 25)}px`;
  } else {
    container.style.height = `${String(height / 1)}px`;
    // set osd wrapper container width
    var container = document.getElementById("section");
    if (container !== null) {
      var width = container.clientWidth;
    }
    var container = document.getElementById("viewer");
    // container.style.width = `${String(width / 0.7)}px`;
  }

  /*
  ##################################################################
  get all image urls stored in page-selector element options
  creates an array for osd viewer with static images
  ##################################################################
  */
  var tileSources = [];
  viewerWidth = document.getElementById("viewer").clientWidth
  if (document.getElementById("page-selector")) {
    [...document.getElementById("page-selector").options].map(o => {
      var imageURL = {
        type: 'image',
        url: o.value.replace('full/full', `full/${viewerWidth},`)
      };
      tileSources.push(imageURL)
    })
  }

  /*
  ##################################################################
  initialize osd
  ##################################################################
  */
  var viewer = OpenSeadragon({
    id: 'container_facs_1',
    prefixUrl: 'https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.0.0/images/',
    sequenceMode: true,
    showNavigator: false,
    tileSources: tileSources
  });
  /*
  ##################################################################
  remove container holding the images url
  ##################################################################
  */
  // setTimeout(function() {
  //     document.getElementById("container_facs_2").remove();
  // }, 500);

  /*
  ##################################################################
  index and previous index for click navigation in osd viewer
  locate index of anchor element
  ##################################################################
  */
  var idx = 0;
  var prev_idx = -1;


  const config = { attributes: true };

  let observer = new MutationObserver((mutations) => {
    mutations.forEach(mutation => {
      if (mutation.type === "attributes") {
        reader_page = reader.getAttribute("data-page")
        if (viewer.currentPage !== reader_page - 1) {
          viewer.goToPage(reader_page - 1)
        }
        if (pageSelector.selectedIndex !== reader_page - 1) {
          pageSelector.selectedIndex = reader_page - 1
        }
        var textContainer = document.getElementById("section");
        if (textContainer) {
          textContainer.scrollTop = 0;
        }
      }
    })
  });

  observer.observe(reader, config);



  /*
  ##################################################################
  accesses osd viewer prev and next button to switch image and
  scrolls to next or prev span element with class pb (pagebreak)
  ##################################################################
  */

  var prev = document.querySelector("div[title='Previous page']");
  var next = document.querySelector("div[title='Next page']");

  /** text paging buttons **/
  var prevPageButton = document.querySelector("#prevPage");
  var nextPageButton = document.querySelector("#nextPage");

  prev.addEventListener("click", () => {
    prevPageButton.click();
  });
  next.addEventListener("click", () => {
    nextPageButton.click();
  });

  /*
  ##################################################################
  function to check if element is close to top of window viewport
  ##################################################################
  */
  function isInViewport(element) {
    // Get the bounding client rectangle position in the viewport
    var bounding = element.getBoundingClientRect();
    // Checking part. Here the code checks if el is close to top of viewport.
    // console.log("Top");
    // console.log(bounding.top);
    // console.log("Bottom");
    // console.log(bounding.bottom);
    if (
      bounding.top <= 180 &&
      bounding.bottom <= 210 &&
      bounding.top >= 0 &&
      bounding.bottom >= 0
    ) {
      return true;
    } else {
      return false;
    }
  }

  /*
  ##################################################################
  function to check if element is anywhere in window viewport
  ##################################################################
  */
  function isInViewportAll(element) {
    // Get the bounding client rectangle position in the viewport
    var bounding = element.getBoundingClientRect();
    // Checking part. Here the code checks if el is close to top of viewport.
    // console.log("Top");
    // console.log(bounding.top);
    // console.log("Bottom");
    // console.log(bounding.bottom);
    if (
      bounding.top >= 0 &&
      bounding.left >= 0 &&
      bounding.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      bounding.right <= (window.innerWidth || document.documentElement.clientWidth)
    ) {
      return true;
    } else {
      return false;
    }
  }


  /*
  ##################################################################
  page selector
  ##################################################################
  */

  togglePrevNextPaging()






  function togglePrevNextPaging() {
    pageSelector = document.getElementById("page-selector");
    if (pageSelector.length == 1) {
      document.getElementById("nextPage").disabled = true;
      document.getElementById("prevPage").disabled = true;
    } else {
      if (pageSelector.selectedIndex == 0) {
        document.getElementById("nextPage").disabled = false;
        document.getElementById("prevPage").disabled = true;
      }
      else if (pageSelector.selectedIndex == pageSelector.length - 1) {
        document.getElementById("prevPage").disabled = false;
        document.getElementById("nextPage").disabled = true;
      }
      else {
        document.getElementById("prevPage").disabled = false;
        document.getElementById("nextPage").disabled = false;
      }
    }
  }

  return {
    selectPage(direction) {
      pageSelector = document.getElementById("page-selector");
      reader_page = parseInt(reader.getAttribute("data-page"));

      if (direction == 'prev') {
        pageSelector.selectedIndex = pageSelector.selectedIndex - 1;
        reader.setAttribute("data-page", reader_page - 1);
      }

      if (direction == 'next') {
        pageSelector.selectedIndex = pageSelector.selectedIndex + 1;
        reader.setAttribute("data-page", reader_page + 1);
      }

      if (!direction) {
        reader.setAttribute("data-page", pageSelector.selectedIndex + 1)
      }

      //imageURL = pageSelector.value;
      pageNr = pageSelector[pageSelector.selectedIndex].text;

      togglePrevNextPaging();



      [...document.querySelectorAll('[id^="page_"]')].forEach(el => {
        el.classList.remove("d-block");
        el.classList.add("d-none")
      }
      )
      document.getElementById(`page_${pageNr}`).classList.remove("d-none")
      document.getElementById(`page_${pageNr}`).classList.add("d-block")
    }
  }

})()

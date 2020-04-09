const selectCreatureType = document.getElementById('creature-list__nav-select-type');
const sortCreatureNav = document.getElementById('creature-list__nav-sort');
const creaturesDisplay = document.getElementById('creature-list__creatures');
const creatureTypeDisplay = document.getElementById('creature-type');
let creatures = [];

const extractType = id => id.substring(7);
const getFish = (data) => data.filter(c => c.c_type === "fish");
const getBugs = (data) => data.filter(c => c.c_type === "bug");

function fetchCreatures(timePeriod, creatureType) {
  fetch(`http://localhost:3000/${timePeriod}`)
    .then(res => res.json())
    .then(json => {
      filterCreatures(json);
      renderCreatures(creatureType);
    })
    .catch(error => console.log(error.message));
}

function filterCreatures(data) {
  creatures.all = [...data];
  creatures.fish = getFish(data);
  creatures.bugs = getBugs(data);

}

function renderTableHeader(creatureType) {
  return `
    <thead>
      <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Location</th>
        <th>Shadow Size</th>
        <th>Time</th>
        <th>Price</th>
      </tr>
    </thead>
  `
}

function renderCreatures(creatureType, creaturesToRender = creatures) {
  if (creatureType === "all") {
    creatureTypeDisplay.innerText = "Creatures";
  } else if (creatureType === "bugs" || creatureType === "fish") {
    creatureTypeDisplay.innerText = creatureType[0].toUpperCase() + creatureType.slice(1);
  }

  creaturesDisplay.innerHTML = renderTableHeader(creatureType);

  creaturesToRender[creatureType].forEach(c => {
    creaturesDisplay.innerHTML += renderCreature(c);
  })
}

function renderCreature(c) {
  return `
      <tr class="creature">
      <th>${c.name}</th>
      <th>${c.c_type}</th>
      <th>${c.location}</th>
      <th>${c.shadow_size ? c.shadow_size : "NA"}
      <th>${c.availables[0].time}</th>
      <th>${c.price}</th>
    </tr>
  `;
}

selectCreatureType.addEventListener('click', (e) => {
  renderCreatures(extractType(e.target.id))
});

window.onload = () => {
  const dt = new Date();
  renderDateTime(dt);
  fetchCreatures("current", "all");
};

function renderDateTime(dt) {
  const cdDisplay = document.getElementById('current-date');
  const ctDisplay = document.getElementById('current-time');
  ctDisplay.innerText = dt.toLocaleTimeString();
  cdDisplay.innerText = dt.toDateString();
}

// sortCreatureNav.addEventListener('click', (e) => {

// })


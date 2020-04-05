const selectCreatureType = document.getElementById('creature-list__nav-select-type');
const creaturesDisplay = document.getElementById('creature-list__creatures');
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
  // switch (creatureType) {
  //   case "fish":
  //     return getFish();
  //   case "bugs":
  //     return getBugs();
  //   default:
  //     return [...data];
  // }
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
        <th>Price</th>
      </tr>
    </thead>
  `
}

function renderCreatures(creatureType) {
  creaturesDisplay.innerHTML = renderTableHeader(creatureType);

  creatures[creatureType].forEach(c => {
    creaturesDisplay.innerHTML += renderCreature(c);
  })
}

function renderCreature(c) {
  return `
      <tr class="creature">
      <th>${c.name}</th>
      <th>${c.c_type}</th>
      <th>${c.location}</th>
      <th>${c.price}</th>
    </tr>
  `;
}

selectCreatureType.addEventListener('click', (e) => {
  // fetchCreatures("current", extractType(e.target.id))
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



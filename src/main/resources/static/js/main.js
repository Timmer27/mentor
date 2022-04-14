// TO MAKE THE MAP APPEAR YOU MUST
// ADD YOUR ACCESS TOKEN FROM
// https://account.mapbox.com
mapboxgl.accessToken = 'pk.eyJ1IjoiZHM3Nzg2IiwiYSI6ImNsMXc4aXRiMDBiYjAzZG8xbGVsMWFicXAifQ.IvWuhchffiyU7UBww6cHzw';
const geojson = {
    'type': 'FeatureCollection',
    'features': [
        {
            'type': 'Feature',
            'properties': {
                'message': 'Foo',
                'iconSize': [30, 30]
            },
            'geometry': {
                'type': 'Point',
                'coordinates': [-66.324462, -16.024695]
            }
        },
        {
            'type': 'Feature',
            'properties': {
                'message': 'Bar',
                'iconSize': [30, 30]
            },
            'geometry': {
                'type': 'Point',
                'coordinates': [-83.1024, 42.3834] 

            }
        },
        {
            'type': 'Feature',
            'properties': {
                'message': 'Baz',
                'iconSize': [30, 30]
            },
            'geometry': {
                'type': 'Point',
                'coordinates': [-63.292236, -18.281518]
            }
        }
    ]
};

const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [0, 0],
    zoom: -2
});

// Add markers to the map.
// 받은 feature의 아이콘 사이즈를 for문으로 돌려서 객체 설정
for (const marker of geojson.features) {
    // Create a DOM element for each marker.
    const el = document.createElement('div');
    const width = marker.properties.iconSize[0];
    const height = marker.properties.iconSize[1];
    el.className = 'marker';
    //여기서 순서대로 돌리는 듯?
    el.style.backgroundImage = `url(/image/logo.jpg)`;
    el.style.width = `${width}px`;
    el.style.height = `${height}px`;
    el.style.backgroundSize = '100%';

	//객체 클릭시 설정된 메세지 출력
/*    el.addEventListener('click', () => {
        window.alert(marker.properties.message);
    });*/

    // Add markers to the map.
    new mapboxgl.Marker(el)
        .setLngLat(marker.geometry.coordinates)
        .addTo(map);
}
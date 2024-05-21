firebase.initializeApp({
    apiKey: "AIzaSyBzKw7yICB5nI0h9WamlX5FKU5ktDqRlkY",
    authDomain: "web-service-pdyp.firebaseapp.com",
    projectId: "web-service-pdyp"
});

//Inicializar cloud firestore
    const db = firebase.firestore();

    // Add documents in DB

    function save()
    {
        const brand = document.getElementById('brand').value;
        const camera = document.getElementById('camera').value;
        const storage = document.getElementById('storage').value;
        const ram = document.getElementById('ram').value;
        const cores = document.getElementById('cores').value;

        db.collection("Smartphones").add({
            brand: brand,
            camera: camera,
            storage: storage,
            ram: ram,
            cores: cores
        })
        .then((docRef) => {
            console.log("Document written with ID: ", docRef.id);
            document.getElementById('brand').value = '';
            document.getElementById('camera').value = '';
            document.getElementById('storage').value = '';
            document.getElementById('ram').value = '';
            document.getElementById('cores').value = '';
        })
        .catch((error) => {
            console.error("Error adding document: ", error);
        });
    }

// Read documents in DB

const table = document.getElementById('table');
db.collection("Smartphones").onSnapshot((querySnapshot) => {
    table.innerHTML = '';
    querySnapshot.forEach((doc) => {
        console.log(`${doc.id} => ${doc.data()}`);
        table.innerHTML += `
        <tr>
        <th scope="row">${doc.id}</th>
        <td>${doc.data().brand}</td>
        <td>${doc.data().camera}</td>
        <td>${doc.data().storage}</td>
        <td>${doc.data().ram}</td>
        <td>${doc.data().cores}</td>
        <td><button class="btn btn-danger" onclick="trash('${doc.id}')">Delete</button></td>
        <td><button class="btn btn-warning" onclick="update('${doc.id}', '${doc.data().brand}', '${doc.data().camera}', '${doc.data().storage}', '${doc.data().ram}', '${doc.data().cores}')">Update</button></td>
      </tr>
      `
    });
});

 
// Delete documents in DB

function trash (id)
{
    db.collection("Smartphones").doc(id).delete().then(() => {
        console.log("Document successfully deleted!");
    }).catch((error) => {
        console.error("Error removing document: ", error);
    });

}

// Update documents in DB

function update (id, brand, camera, storage, ram, cores)
{
    document.getElementById('brand').value = brand;
    document.getElementById('camera').value = camera;
    document.getElementById('storage').value = storage;
    document.getElementById('ram').value = ram;
    document.getElementById('cores').value = cores;
    var btn = document.getElementById('button');
    btn.innerHTML = 'Update';
    btn.onclick = function()
    {
        var smartphone = db.collection("Smartphones").doc(id);

        var brand = document.getElementById('brand').value;
        var camera = document.getElementById('camera').value;
        var storage = document.getElementById('storage').value;
        var ram = document.getElementById('ram').value;
        var cores = document.getElementById('cores').value;

        return smartphone.update({
            brand: brand,
            camera: camera,
            storage: storage,
            ram: ram,
            cores: cores
        })
        .then(() => {
            console.log("Document successfully updated!");
            document.getElementById('brand').value = '';
            document.getElementById('camera').value = '';
            document.getElementById('storage').value = '';
            document.getElementById('ram').value = '';
            document.getElementById('cores').value = '';
            btn.innerHTML = 'Save';
        })
        .catch((error) => {
            // The document probably doesn't exist.
            console.error("Error updating document: ", error);
        });
    }


}








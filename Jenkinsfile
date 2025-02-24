pipeline {
    agent any
    
    environment {
        CONTAINER_ID = ''  // Stockera l'ID du conteneur Docker exécuté
        SUM_FILE_PATH = '/chemin/vers/sum.py'  // Chemin vers sum.py sur la machine locale
        DIR_PATH = '/chemin/vers/le/repertoire/contenant/Dockerfile'  // Chemin du répertoire avec le Dockerfile
        TEST_FILE_PATH = '/chemin/vers/le/fichier/test'  // Chemin vers le fichier test
    }

    stages {
        stage('Initialisation') {
            steps {
                script {
                    echo "Agent défini et variables d'environnement configurées."
                }
            }
        }
    }


    stages {
        stage('Build') {
            steps {
                script {
                    echo "Construction de l'image Docker..."
                    sh "docker build -t python-sum ${DIR_PATH}"
                }
            }
        }
    }
}
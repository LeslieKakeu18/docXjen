pipeline {
    agent any  // Exécute le pipeline sur n'importe quel agent disponible
    
    environment {
        CONTAINER_ID = ''  // Stocke l'ID du conteneur Docker exécuté
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

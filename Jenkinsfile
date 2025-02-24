pipeline {
    agent any
    
    environment {
        CONTAINER_ID = ''  
        SUM_FILE_PATH = 'C:\\chemin\\vers\\sum.py'  
        DIR_PATH = 'C:\\chemin\\vers\\le\\repertoire\\contenant\\Dockerfile'  
        TEST_FILE_PATH = 'C:\\chemin\\vers\\le\\fichier\\test'  
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
                    bat "docker build -t python-sum %DIR_PATH%"
                }
            }
        }
    }
}

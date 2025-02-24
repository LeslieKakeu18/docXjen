pipeline {
    agent any
    
    environment {
        CONTAINER_ID = ''  
        SUM_FILE_PATH = 'C:\\Users\\kakeu\\Downloads\\DOCJEN\\sum.py'  
        DIR_PATH = 'C:\\Users\\kakeu\\Downloads\\DOCJEN'  
        TEST_FILE_PATH = 'C:\\Users\\kakeu\\Downloads\\DOCJEN\\test'  
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

        stage('Run') {
            steps {
                script {
                    echo "Exécution du conteneur Docker..."
                    CONTAINER_ID = sh(script: "docker run -d python-sum tail -f /dev/null", returnStdout: true).trim()
                    echo "Conteneur démarré avec l'ID: ${CONTAINER_ID}"
                }
            }
        }
    }
}

pipeline {
    agent any
    
    environment {
        DOCKERHUB_USER = 'leslie18'   
        DOCKERHUB_REPO = 'python-sum'
        IMAGE_NAME = 'my-python-sum'
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
                    bat "docker build -t ${IMAGE_NAME} %DIR_PATH%"
                }
            }
        }

        stage('Run') {
            steps {
                script {
                    echo "Exécution du conteneur Docker..."
                    def output = bat(script: "docker run -d ${IMAGE_NAME}", returnStdout: true).trim()
                    def lines = output.split('\n')
                    def containerId = lines[-1].trim()
                    echo "Conteneur démarré avec l'ID: ${containerId}"
                    
                    env.CONTAINER_ID = containerId
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Début des tests..."
                    bat "docker exec ${env.CONTAINER_ID} ls /app/"

                    def testLines = readFile(TEST_FILE_PATH).trim().split('\n')

                    for (line in testLines) {
                        def vars = line.trim().split('\\s+')
                        def arg1 = vars[0]
                        def arg2 = vars[1]
                        def expectedSum = vars[2].toFloat()

                        echo "Test avec ${arg1} + ${arg2}, somme attendue : ${expectedSum}"

                        def output = bat(script: "docker exec ${env.CONTAINER_ID} python3 /app/sum.py ${arg1} ${arg2}", returnStdout: true).trim()

                        echo "Sortie brute de sum.py : ${output}"
                        def result = output.split('\n')[-1].trim().toFloat()

                        if (result == expectedSum) {
                            echo "Test réussi : ${arg1} + ${arg2} = ${result}"
                        } else {
                            error "Échec du test : ${arg1} + ${arg2}, attendu ${expectedSum} mais obtenu ${result}"
                        }
                    }
                }
            }
        }

       stage('Deploy') {
    steps {
        script {
            echo "Connexion à DockerHub..."
            
            withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_CREDENTIALS', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                // Connexion à DockerHub
                bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"

                // Taguer l'image avant de la pousser
                bat "docker tag python-sum %DOCKER_USER%/python-sum:latest"

                // Pousser l'image sur DockerHub
                bat "docker push %DOCKER_USER%/python-sum:latest"

                echo "Image poussée avec succès sur DockerHub !"
            }
        }
    }
}
    }

    post {
        always {
            script {
                echo "Arrêt et suppression du conteneur Docker..."
                bat "docker stop ${env.CONTAINER_ID} || true"
                bat "docker rm ${env.CONTAINER_ID} || true"
            }
        }
    }
}

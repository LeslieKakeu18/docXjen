pipeline {
    agent any
    
    environment {
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
                    def output = bat(script: 'docker run -d python-sum', returnStdout: true).trim()
                    def lines = output.split('\n')
                    def containerId = lines[-1].trim()
                    echo "Conteneur démarré avec l'ID: ${containerId}"
                    
                    // Sauvegarde du conteneur pour utilisation dans les étapes suivantes
                    env.CONTAINER_ID = containerId
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Début des tests..."
                    
                    // Vérification que le conteneur tourne et que le script est bien présent
                    bat "docker exec ${env.CONTAINER_ID} ls /app/"

                    // Lecture et nettoyage du fichier de test
                    def testLines = readFile(TEST_FILE_PATH).trim().split('\n')

                    for (line in testLines) {
                        def vars = line.trim().split('\\s+') // Gère les espaces multiples
                        def arg1 = vars[0]
                        def arg2 = vars[1]
                        def expectedSum = vars[2].toFloat()

                        // Vérification des valeurs lues
                        echo "Test avec ${arg1} + ${arg2}, somme attendue : ${expectedSum}"

                        // Exécution du script dans le conteneur Docker
                        def output = bat(script: "docker exec ${env.CONTAINER_ID} python3 /app/sum.py ${arg1} ${arg2}", returnStdout: true).trim()

                        // Affichage de la sortie pour débogage
                        echo "Sortie brute de sum.py : ${output}"

                        // Extraction du dernier élément
                        def result = output.split('\n')[-1].trim().toFloat()

                        // Vérification du résultat
                        if (result == expectedSum) {
                            echo "Test réussi : ${arg1} + ${arg2} = ${result}"
                        } else {
                            error "Échec du test : ${arg1} + ${arg2}, attendu ${expectedSum} mais obtenu ${result}"
                        }
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

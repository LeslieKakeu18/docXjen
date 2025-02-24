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
                    def output = bat(script: 'docker run -d python-sum', returnStdout: true)
                    def lines = output.split('\n')
                    CONTAINER_ID = lines[-1].trim()
                    echo "Conteneur démarré avec l'ID: ${CONTAINER_ID}"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                     echo "Début des tests..."

                    // Lecture du fichier de test
                    def testLines = readFile(TEST_FILE_PATH).split('\n')

                    for (line in testLines) {
                    def vars = line.split(' ')
                    def arg1 = vars[0]
                    def arg2 = vars[1]
                    def expectedSum = vars[2].toFloat()

                    // Exécution du script Python dans le conteneur Docker
                    def output = bat(script: "docker exec ${CONTAINER_ID} python /sum.py ${arg1} ${arg2}", returnStdout: true)

                    // Extraction et conversion du résultat
                    def result = output.split('\n')[-1].trim().toFloat()

                    // Comparaison avec la somme attendue
                    if (result == expectedSum) {
                    echo "Test réussi : ${arg1} + ${arg2} = ${result}"
                    } else {
                    error "Échec du test : ${arg1} + ${arg2} attendu ${expectedSum} mais obtenu ${result}"
                }
            }
        }
    }
}

    }
}

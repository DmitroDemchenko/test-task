from flask import Flask
from urllib.request import urlopen
import json
app = Flask(__name__)
@app.route("/")
def hello():
    response = urlopen('http://dummy.restapiexample.com/api/v1/employees')
    employee = json.loads(response.read())

    employee_list = {}
    for count in range(len(employee['data'])):
        employee_list.update({count : employee['data'][count]['employee_name']})

    return employee_list

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("9001"), debug=True)
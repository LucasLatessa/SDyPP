from flask import Flask, jsonify, request
from sobel_Parte1 import sobel
import os
import json
import numpy as np

app = Flask(__name__)

@app.route(rule="/sobel",methods=["POST"])
def aplicar_sobel():

    imagen = request.json["imagenes"]
    print(request.json["id"])
    #print(imagen)
    #print("SEPARADOR")
    imagen_np = np.array(imagen,dtype=np.uint8)
    imagen_np = np.squeeze(imagen_np)
    #print(imagen_np)
    #print(type(imagen_np))

    imagen_sobel = sobel(imagen_np)

    # Convertir todas las imágenes a una lista de diccionarios JSON
    imagenes_json = [{"imagen": imagen.tolist()} for imagen in imagen_sobel]

    imagen_sobel_json = {
        "imagen" : imagen_sobel.tolist()
    }
    
    return jsonify(imagen_sobel_json)
    
    #return "hola"
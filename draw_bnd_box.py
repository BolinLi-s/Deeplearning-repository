import xml.etree.ElementTree as ET

import cv2
import numpy as np
import glob

from data_crop import *
import shutil


img_dir = 'split_flower'
xml_dir = 'split_xml'


def read_xml():

    object_axis = {}

    for xml_file in glob.glob(xml_dir + '/*.xml'):
        # print(xml_file)
        tree = ET.parse(xml_file)
        root = tree.getroot()
        object_axis[xml_file.split('/')[1].split('.')[0]] = []
        for member in root.findall('object'):
            x_min = int(member[0][0].text)
            y_min = int(member[0][1].text)
            x_max = int(member[0][2].text)
            y_max = int(member[0][3].text)
            object_axis[xml_file.split('/')[1].split('.')[0]].append((x_min, y_min, x_max,y_max))

    
        if len(object_axis[xml_file.split('/')[1].split('.')[0]]) == 0:
            object_axis.pop(xml_file.split('/')[1].split('.')[0])

    return object_axis

def draw():

    axis = read_xml()
    count = 0
    length = len(axis)
    for key, values in axis.items():
        positive_path = 'split_flower/' + key + '.JPG'

        image = cv2.imread(positive_path)
        for value in values:

            draw_img = cv2.rectangle(image, (value[0], value[1]), (value[2], value[3]), (255,0,0), 2)
            cv2.imwrite('positive_flower/' + key + '.JPG', image)
        shutil.copy('split_xml/' + key + '.xml', 'positive_xml/' + key + '.xml')
        count += 1

        print('[{}/{}] progressive bar~'.format(count, length))

        



draw()


# print(obj_axis)
# print('over')
# a = {}
# a['sd'] = []
# print(len(a['sd']))
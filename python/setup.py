from setuptools import find_packages, setup

setup(
    name='bowling_game',
    version='0.0.1',
    python_requires='>=3.6',
    extras_require=dict(tests=['pytest']),
    packages=find_packages(where="src"),
    package_dir={"": "src"},
)
